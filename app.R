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
                 ),
                 
                 tabPanel("Redraft",icon = icon("table"),
                   fluidPage(
                     fluidRow(
                       column(11),
                       column(1, strong("Last updated:"),Sys.Date())
                     ),
                     br(),
                     dataTableOutput("redraft"),
                     br(),br(),br(),br()
                   )
                 )
                 
                 
)


server <- function(input, output) {
   
  output$rookie <- renderDataTable({
    
    gsheet2tbl("https://docs.google.com/spreadsheets/d/1PGCcFzsoXhofokFyuuJbsYv_JAo_GDTCalfLQtHgxuE/edit#gid=1611480279")
    
  }, rownames = FALSE, options = list(paging = FALSE, dom = "t"))
  
  output$redraft <- renderDataTable({
    
    gsheet2tbl("https://docs.google.com/spreadsheets/d/1ebObabswol2sFVHMO9r5qW4YmU1E-psh1_IDIjIK41o/edit#gid=0") %>%
      group_by(Position) %>%
      mutate(PosRank = rank(Consensus, ties.method = "first"))
    
  }, rownames = FALSE, options = list(paging = FALSE, dom = "t"))
  
}

# Run the application 
shinyApp(ui = ui, server = server)

