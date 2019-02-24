library(shiny)
library(DT)
library(dplyr)

sheetsdynasty <- read.csv("https://docs.google.com/spreadsheets/d/e/2PACX-1vT3b5Wzj-dGNkzY5ZwXfELV-RKo6BoCCfs7A6YyiLB6G-ZVmyv2U9zed2xcROyLLln7Lk_y4J7isgOU/pub?gid=1611480279&single=true&output=csv")
sheetsdynasty <- sheetsdynasty %>% filter(Average > 0)

ui <- navbarPage("FFStatistics Rankings", position = "fixed-top",
                 header = tags$style(type="text/css", "body {padding-top: 70px;}"), collapsible = TRUE,
                 
                 tabPanel("Rookie",icon = icon("table"),
                            fluidPage(
                              fluidRow(
                                column(11,tags$a(img(src="logo.png",height="50px",width="50px")))
                              ),
                              br(),
                              dataTableOutput("rookie")
                            )
                 )
                 
                 
)


server <- function(input, output) {
   
  output$rookie <- renderDataTable({
    
    sheetsdynasty
    
  }, rownames = FALSE, options = list(paging = FALSE, dom = "t")) 
  
}

# Run the application 
shinyApp(ui = ui, server = server)

