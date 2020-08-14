#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotly)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  source("SIRFunctions.R") # load SIR functions
  
  output$SIRPlot <- renderPlotly({
    
    plotDat <- runSIR(R0 = input$R0, gamma = input$gamma)
    plotSIR(plotDat)
    
  })
  
  output$Totals <- renderTable(matrix(NA, 1, 1))
  
})
