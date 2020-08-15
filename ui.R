#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotly)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("SIR Model"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       sliderInput("R0",
                   "Infection rate (R0)",
                   min = 0,
                   max = 10,
                   value = 2,
                   step = 0.1),
       sliderInput("gamma",
                   "Recovery rate (gamma)",
                   min = 0,
                   max = 0.5,
                   value = 0.05,
                   step = 0.01),
       sliderInput("init",
                   "Initial infections (%)",
                   min = 0,
                   max = 1,
                   value = 0.01,
                   step = 0.01),
       p("Adjust the sliders to see how assumptions about transmission and recovery rates affect outcomes."),
       p("Percentage of the population infected at 600 days."),
       tableOutput("Totals")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       plotlyOutput("SIRPlot")
    )
  )
))
