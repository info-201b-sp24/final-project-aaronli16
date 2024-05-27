library(shiny)

ui <- navbarPage("Student Alcohol Consumption",
  tabPanel("Introduction",
    fluidPage(
      titlePanel("Student Alcohol Consumption: At a Glance"),
      p("Abstract: This study analyzes student alcohol consumption data to identify patterns and trends..."),
      # Add other elements for the introduction here
    )
  ),
  tabPanel("Alcohol Consumption by Major",
    fluidPage(
      titlePanel("How the Majors Consume Alcohol"),
      p("This bar chart shows the average number of drinks consumed per night out by students from different majors."),
      p("Description: I chose to use a bar chart to depict the data between average drinks per night out and major because it is easy to read and understand..."),
      p("Insights: When looking at the Bar chart, Law and Agricultural Sciences seem to stand out as outliers in drinking..."),
      plotOutput("barChart")
    )
  )
  
)


