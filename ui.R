# Ashraf Youssef
# 4/24/2016
#  
# This is the UI file for my first Shiny app.
#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("This application displays the monthly support ticket count for the applications selected"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      
     uiOutput("choose_apps")
       
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       plotOutput("distPlot")
       
# For diagnostics     textOutput("text1"),
       
    )
  )
))
