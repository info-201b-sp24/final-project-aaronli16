library(shiny)

ui <- navbarPage("Student Alcohol Consumption",
  tabPanel("Introduction",
    fluidPage(
      titlePanel("Student Alcohol Consumption: At a Glance"),
      p("Abstract: This study analyzes student alcohol consumption data to identify patterns and trends..."),
      
    )
  ),
  tabPanel("Major and School Year",
           fluidPage(
             titlePanel("Average Drinks Per Week by Major and School Year"),
             sidebarLayout(
               sidebarPanel(
                 checkboxGroupInput("selected_majors", "Select Majors:",
                                    choices = NULL,
                                    selected = NULL),
                 checkboxGroupInput("selected_years", "Select School Years:",
                                    choices = NULL,
                                    selected = NULL)
               ),
               mainPanel(
                 plotOutput("barChart")
               )
             )
           )
  )
)



