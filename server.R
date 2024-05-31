library(shiny)
library(ggplot2)
library(dplyr)

server <- function(input, output, session) {

  data <- read.csv("https://drive.google.com/uc?export=download&id=1skt9wt6XkT1O8zBC3DKvZG988pnHKGC_")

  names(data) <- c('Timestamp', 'Sex', 'Avg_GPA', 'School_Year', 'Major',
                   'Avg_GPA_2023', 'Accommodation_Status', 'Monthly_Allowance',
                   'Scholarship_2023', 'Study_Hours_Per_Week', 'Party_Frequency',
                   'Drinks_Per_Night_Out', 'Classes_Missed_Per_Week',
                   'Classes_Failed', 'Romantic_Relationship', 'Parental_Approval_Alcohol',
                   'Relationship_With_Parents')

  data$Major[data$Major == "" | is.na(data$Major)] <- "Undecided"
  data$Major <- as.factor(data$Major)

  data <- data %>% filter(School_Year != "" & !is.na(School_Year))
  data$School_Year <- as.factor(data$School_Year)

  data$Drinks_Per_Night_Out <- as.numeric(sapply(data$Drinks_Per_Night_Out, function(x) {
    if (grepl("-", x)) {
      parts <- strsplit(x, "-")[[1]]
      return(mean(as.numeric(parts)))
    } else if (grepl("\\+", x)) {
      return(as.numeric(gsub("\\+", "", x)))
    } else {
      return(as.numeric(x))
    }
  }))

  data <- data %>%
    group_by(Major, School_Year) %>%
    summarise(Average_Drinks_Per_Week = mean(Drinks_Per_Night_Out, na.rm = TRUE))

  updateCheckboxGroupInput(session, "selected_majors", choices = unique(data$Major), selected = unique(data$Major))
  updateCheckboxGroupInput(session, "selected_years", choices = unique(data$School_Year), selected = unique(data$School_Year))

  filtered_data <- reactive({
    data %>%
      filter(Major %in% input$selected_majors,
             School_Year %in% input$selected_years)
  })

  output$barChart <- renderPlot({
    ggplot(filtered_data(), aes(x = Major, y = Average_Drinks_Per_Week, fill = School_Year)) +
      geom_bar(stat = "identity", position = "dodge", color = "black") +
      theme_minimal() +
      scale_fill_manual(values = c("1st Year" = "#1f77b4", "2nd Year" = "#ff7f0e", "3rd Year" = "#2ca02c", "4th Year" = "#d62728")) +
      labs(title = "Average Number of Drinks Per Week by Major and School Year",
           x = "Major", y = "Average Drinks Per Week") +
      theme(axis.title.x = element_text(size = 15),
            axis.title.y = element_text(size = 15),
            plot.title = element_text(size = 25, face = "bold"),
            axis.text.x = element_text(size = 12, angle = 45, hjust = 1),
            axis.text.y = element_text(size = 12))
  })
}
