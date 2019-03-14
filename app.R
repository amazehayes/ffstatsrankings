library(shiny)
library(DT)
library(dplyr)
library(googlesheets)

gs_auth()
key <- gs_key("1PGCcFzsoXhofokFyuuJbsYv_JAo_GDTCalfLQtHgxuE")
rankings <- gs_title(key$sheet_title) %>% gs_read_csv(ws = "Dynasty")

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
    
    rankings
    
  }, rownames = FALSE, options = list(paging = FALSE, dom = "t")) 
  
}

# Run the application 
shinyApp(ui = ui, server = server)

