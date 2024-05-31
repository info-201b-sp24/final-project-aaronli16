library(shiny)
library(ggplot2)
library(dplyr)
library(waffle)

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
  
  data <- data %>%
    filter(!is.na(Drinks_Per_Night_Out) & Drinks_Per_Night_Out != "",
           !is.na(Relationship_With_Parents) & Relationship_With_Parents != "",
           !is.na(Parental_Approval_Alcohol) & Parental_Approval_Alcohol != "")
  
  data$Relationship_With_Parents <- factor(data$Relationship_With_Parents, 
                                           levels = c("Distant", "Fair", "Close", "Very close"))
  data$Parental_Approval_Alcohol <- as.factor(data$Parental_Approval_Alcohol)
  data$Romantic_Relationship <- as.factor(data$Romantic_Relationship)
  
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
  
  data_major <- data %>%
    group_by(Major, School_Year) %>%
    summarise(Average_Drinks_Per_Week = mean(Drinks_Per_Night_Out, na.rm = TRUE))
  
  # Update checkbox group inputs
  updateCheckboxGroupInput(session, "selected_majors", choices = unique(data_major$Major), selected = unique(data_major$Major))
  updateCheckboxGroupInput(session, "selected_years", choices = unique(data_major$School_Year), selected = unique(data_major$School_Year))
  
  filtered_data <- reactive({
    data_major %>%
      filter(Major %in% input$selected_majors,
             School_Year %in% input$selected_years)
  })
  
  output$barChartMajor <- renderPlot({
    ggplot(filtered_data(), aes(x = Major, y = Average_Drinks_Per_Week, fill = School_Year)) +
      geom_bar(stat = "identity", position = "dodge") +
      theme_minimal() +
      labs(title = "Average Number of Drinks Per Week by Major and School Year",
           x = "Major", y = "Average Drinks Per Week") +
      theme(axis.title.x = element_text(size = 15),
            axis.title.y = element_text(size = 15),
            plot.title = element_text(size = 25, face = "bold"),
            axis.text.x = element_text(size = 12, angle = 45, hjust = 1),
            axis.text.y = element_text(size = 12)) +
      scale_fill_brewer(palette = "Pastel1")
  })
  
  # Parental relationship and approval data filtering
  output$barChartPpl <- renderPlot({
    filtered_ppl <- data %>% 
      filter(
        Parental_Approval_Alcohol == ifelse(input$parental_approval, "Yes", "No"),
        Relationship_With_Parents == input$parental_relationship,
        Romantic_Relationship == ifelse(input$relationship_status, "Yes", "No")
      )
    
    avg_drinks <- round(mean(filtered_ppl$Drinks_Per_Night_Out, na.rm = TRUE), 1)
    
    if (is.na(avg_drinks) || avg_drinks == 0) {
      plot.new()
      text(0.5, 0.5, "No drinks consumed on average", cex = 1.5)
    } else {
      waffle(
        parts = c('Drinks' = avg_drinks), 
        rows = 1, 
        colors = c("red"),
        legend_pos = "none",
        title = "Average Drinks Consumed",
        xlab = "1 square represents 1 drink"
      )
    }
  })

}


