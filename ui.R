library(shiny)
library(shinyWidgets)

ui <- navbarPage("Student Alcohol Consumption",
                 tabPanel("Introduction",
                          fluidPage(
                            titlePanel("Student Alcohol Consumption: At a Glance"),
                            p("This is our study on 'Student Alcohol Consumption: At a Glance'. This project aims to analyze the patterns and trends of alcohol consumption by students based on factors like their major, academic performance, and parental influence. The data for this study is sourced from a publicly available dataset on Kaggle, 'Student Alcohol Consumption,' containing responses from students regarding their drinking habits, academic performance, and various personal and demographic factors via surveys."),
                            p("The major questions we seek to answer through this analysis are:"),
                            tags$ul(
                              tags$li("How does alcohol consumption correlate with a student's major and year?"),
                              tags$li("How does alcohol consumption affect a student's performance in school?"),
                              tags$li("How do the people around a student affect a student’s alcohol consumption?")
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
                            p("How does alcohol consumption correlate with a student's major and year? The barchart below seeks to figure out how alcohol consumption is related to a students major and year. Using the checkboxes you can filter for certain years or majors."),
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
                            tags$head(
                                                      # Note the wrapping of the string in HTML()
                              tags$style(HTML("
                                @import url('https://fonts.googleapis.com/css2?family=Yusei+Magic&display=swap');
                                @import url('https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&display=swap');
                                h2 {
                                  font-family: 'Yusei Magic', sans-serif;
                                  text-shadow: 2px 2px 0px grey;
                                }
                                
                                p {
                                  font-family: 'Roboto', sans-serif;
                                }
                                
                                body {
                                  cursor: url('https://d1nhio0ox7pgb.cloudfront.net/_img/g_collection_png/standard/32x32/wine.png'),pointer;
                                }
                                "))
                            ),
                            titlePanel("How the People Around Students Affect Alcohol Consumption"),
                            p("How do the people around a student affect a student’s alcohol consumption? The pictogram below seeks to display a student's drinking habits depending on the interpersonal relationships they have. Based on the controls below you can filter students out to find trends in how parents or partners may affect alcohol consumption."),
                            sidebarPanel(
                              p("Is the student's parent ok with them drinking alcohol?"),
                              switchInput(
                                inputId = "parental_approval",
                                onLabel = "Yes",
                                offLabel = "No",
                                offStatus = "danger"
                              ),
                              p("Is the student currently in a romantic relationship?"),
                              switchInput(
                                inputId = "relationship_status",
                                onLabel = "Yes",
                                offLabel = "No",
                                offStatus = "danger"
                              ),
                              sliderTextInput(
                                inputId = "parental_relationship",
                                label = "How close is the student to their parents?",
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
                 tabPanel("Academic Performance",
                          fluidPage(
                            titlePanel("GPA and Classes Missed From Alcohol"),
                            p("How does alcohol consumption affect a student's performance in school? The line plot attempts to graph the relationship between alcohol consumption and classes missed per week. Additionally, the controls on the left allows you to filter for GPA and Classes failed."),
                            sidebarPanel(
                              sliderInput(
                                inputId = "GPA",
                                label = "Choose a Range of GPAs",
                                min = 0, max = 100,
                                value = c(0, 100),
                                ticks = TRUE,
                                dragRange = TRUE
                              ),
                              sliderTextInput(
                                inputId = "ClassFailed",
                                label = "Choose a Range of Classes Failed",
                                force_edges = TRUE,
                                choices = c("1", "2", "3", "4+"),
                                selected = c("1", "4+")
                              )
                            ),
                            mainPanel(
                              plotOutput("linePerf")
                            )
                          )
                 ),
                 tabPanel("Conclusion",
                          fluidPage(
                            titlePanel("Key Takeaways"),
                            p("After analyzing the dataset, we identified key takeaways regarding patterns of alcohol consumption among students. Firstly, we found that 4th year Agricultural Science majors and postgraduate Engineers reported some of the highest average weekly intake across all groups, suggesting a culture of drinking within these groups. The postgraduate Economic & Management Sciences discipline, on the other hand, show the lowest consumption, which may reflect a change in priorities as students delve into their field deeper. A general increase in consumption from the first to third years is observed, possibly due to greater social integration and freedom. However, there’s a slight decrease or plateau by the fourth year, indicating a potential shift in priorities as students near graduation. This data is crucial for understanding student behavior and guiding university policies on alcohol education."),
                            p("Secondly, our analysis revealed a relationship between alcohol consumption and academic performance. Students with higher average GPAs tended to consume fewer alcoholic drinks per week. This inverse correlation suggests that excessive alcohol consumption may negatively impact students' academic performance, possibly due to reduced study time and increased class absences resulting from hangovers or fatigue."),
                            p("Thirdly, the influence of parents on students' drinking behavior was notable. Students whose parents disapproved of alcohol consumption generally reported lower levels of drinking. This finding underscores the role of parental attitudes and communication in shaping students' behaviors and choices."),
                            p("Overall the most important takeaway from this analysis is that alcohol consumption seems to rely on a variety of factors, from a student's major and year to their parents and partners. Thus, overall we believe that any alcohol policy shouldn't focus on just one factor but should take a multilateral approach and should attempt to change the underlying culture behind drinking in order to properly reduce it."),
                            p("The data provides valuable insights into the complex connections and correlations between alcohol consumption, academic performance, and parental influence among students. These findings highlight the importance of targeted interventions and support systems to address alcohol-related issues within the student population. Universities and policymakers can use these insights to develop programs that promote healthier lifestyles and academic success. By understanding the factors that contribute to alcohol consumption, stakeholders can create more effective strategies to mitigate its negative effects and support students in achieving their academic and personal goals."),
                            p("Overall, this study demonstrates the utility of data-driven approaches in uncovering trends and informing policy decisions. We hope this project serves as a foundation for further research into the impact of alcohol consumption on student life.")
                          )
                 )
)