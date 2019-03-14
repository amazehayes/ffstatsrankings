library(shiny)
library(DT)
library(dplyr)
library(gsheet)

ui <- navbarPage("FFStatistics Rankings", position = "fixed-top",
                 header = tags$style(type="text/css", "body {padding-top: 70px;}"), collapsible = TRUE,
                 
                 tabPanel("Rookie",icon = icon("table"),
                            fluidPage(
                              fluidRow(
                                column(11),
                                column(1, strong("Last updated:"),Sys.Date())
                              ),
                              br(),
                              dataTableOutput("rookie"),
                              br(),br(),br(),br()
                            )
                 )
                 
                 
)


server <- function(input, output) {
   
  output$rookie <- renderDataTable({
    
    gsheet2tbl("https://docs.google.com/spreadsheets/d/1PGCcFzsoXhofokFyuuJbsYv_JAo_GDTCalfLQtHgxuE/edit#gid=1611480279")
    
  }, rownames = FALSE, options = list(paging = FALSE, dom = "t")) 
  
}

# Run the application 
shinyApp(ui = ui, server = server)

