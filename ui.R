library(shiny)

ui <- navbarPage("Student Alcohol Consumption",
  tabPanel("Introduction",
    fluidPage(
      titlePanel("Student Alcohol Consumption: At a Glance"),
      p("Abstract: This study analyzes student alcohol consumption data to identify patterns and trends...")
    )
  ),
  tabPanel("Alcohol Consumption by Major and School Year",
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
                 plotOutput("barChart"),
                 HTML('<p style="font-size:18px;"><strong>Description:</strong> By visualizing these trends, we can identify student groups that may benefit from targeted health and wellness programs. High consumption in fields like Engineering and AgriSciences suggests a need for stress management and social responsibility initiatives. Conversely, understanding the low consumption in Law, Medicine, and Sciences can provide insights into how academic pressures and professional expectations shape student behaviors. This analysis is crucial for university administrators and student services to develop tailored interventions, promoting a healthier campus environment.</p>
                      <p style="font-size:18px;"><strong>How to Use the Graph:</strong> The bar chart below allows you to explore the average number of alcoholic drinks consumed per week by students, categorized by their major and school year. Use the checkboxes on the left to select specific majors and school years you are interested in. The bars will update dynamically to reflect your selections, providing a clear visual comparison across different groups. This interactive feature helps you focus on particular demographics and understand their drinking patterns more precisely.</p>')
               )
             )
           )
  )
)
