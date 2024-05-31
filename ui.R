library(shiny)
library(shinyWidgets)

ui <- navbarPage("Student Alcohol Consumption",
                 tabPanel("Introduction",
                          fluidPage(
                            titlePanel("Student Alcohol Consumption: At a Glance"),
                            p("This is our study on 'Student Alcohol Consumption: At a Glance'. This project aims to analyze the patterns and trends of alcohol consumption by students based on factors like their major, academic performance, and parental influence. The data for this study is sourced from a publicly available dataset on Kaggle, 'Student Alcohol Consumption,' containing responses from students regarding their drinking habits, academic performance, and various personal and demographic factors via surveys."),
                            p("The major questions we seek to answer through this analysis are:"),
                            tags$ul(
                              tags$li("How does alcohol consumption correlate with a student's major?"),
                              tags$li("How does alcohol consumption correlate with grades in each major?"),
                              tags$li("How do parents affect a student’s alcohol consumption?")
                            ),
                            p("The dataset provides a comprehensive view of students' backgrounds, study habits, and social behaviors. By examining these variables, we hope to uncover insights into how different factors influence alcohol consumption among university students."),
                            p("It's important to consider some ethical questions and limitations associated with this dataset. The data is self-reported, which may introduce biases or inaccuracies. Also, the sensitive nature of personal information requires careful handling to ensure privacy and confidentiality."),
                            p("For a more detailed exploration of the dataset, please navigate through the interactive pages of this Shiny application. We hope this project not only provides valuable insights but also encourages further discussion and research on the impact of alcohol consumption on students' academic and personal lives."),
                            a(href = "https://www.kaggle.com/datasets/joshuanaude/url", "Kaggle Dataset: Student Alcohol Consumption"),
                            img(src = "https://github.com/info-201b-sp24/final-project-aaronli16/blob/4e3aca397f291df23f0a2ecb2af2d7d72a7b6bbf/college-students-toasting-over-beer.jpeg?raw=true", height = "300px", width = "500px")
                          )
                 ),
                 tabPanel("Major and School Year",
                          fluidPage(
                            titlePanel("Average Drinks Per Week by Major and School Year"),
                            sidebarPanel(
                              checkboxGroupInput("selected_majors", "Select Majors:", choices = NULL, selected = NULL),
                              checkboxGroupInput("selected_years", "Select School Years:", choices = NULL, selected = NULL)
                            ),
                            mainPanel(
                              plotOutput("barChartMajor")
                            )
                          )
                 ),
                 tabPanel("Interpersonal Relationships",
                          fluidPage(
                            titlePanel("How the People Around Students Affect Alcohol Consumption"),
                            sidebarPanel(
                              "Is the student's parent ok with them drinking alcohol?",
                              switchInput(
                                inputId = "parental_approval",
                                onLabel = "Yes",
                                offLabel = "No",
                                offStatus = "danger"
                              ),
                              sliderTextInput(
                                inputId = "parental_relationship",
                                label = "Your choice:",
                                force_edges = TRUE,
                                choices = c("Distant", "Fair", "Close", "Very close"),
                                selected = "Close"
                              )
                            ),
                            mainPanel(
                              plotOutput("barChartPpl")
                            )
                          )
                 ),
                 tabPanel("Conclusion",
                          fluidPage(
                            titlePanel("Key Takeaways"),
                            p("After analyzing the dataset, we identified key takeaways regarding patterns of alcohol consumption among students. Firstly, we found a significant correlation between a student's major and drinking habits. Students from certain majors reported higher average alcohol consumption compared to their peers in other disciplines. This trend could be due to the cultural and social factors that exist within different fields of study."),
                            p("Secondly, our analysis revealed a relationship between alcohol consumption and academic performance. Students with higher average GPAs tended to consume fewer alcoholic drinks per week. This inverse correlation suggests that excessive alcohol consumption may negatively impact students' academic performance, possibly due to reduced study time and increased class absences resulting from hangovers or fatigue."),
                            p("Thirdly, the influence of parents on students' drinking behavior was notable. Students whose parents disapproved of alcohol consumption generally reported lower levels of drinking. This finding underscores the role of parental attitudes and communication in shaping students' behaviors and choices."),
                            p("The data provides valuable insights into the complex connections and correlations between alcohol consumption, academic performance, and parental influence among students. These findings highlight the importance of targeted interventions and support systems to address alcohol-related issues within the student population. Universities and policymakers can use these insights to develop programs that promote healthier lifestyles and academic success. By understanding the factors that contribute to alcohol consumption, stakeholders can create more effective strategies to mitigate its negative effects and support students in achieving their academic and personal goals."),
                            p("Overall, this study demonstrates the utility of data-driven approaches in uncovering trends and informing policy decisions. We hope this project serves as a foundation for further research into the impact of alcohol consumption on student life."),
                            tableOutput("summaryTable")
                          )
                 )
)