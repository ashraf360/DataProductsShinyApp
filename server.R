# Ashraf Youssef
# 4/24/2016
# First Shiny application to display support tickets per month
#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required pull in all the relevant data for the display

## Clean the data by grouping by 

library(dplyr)
library(ggplot2)
library(gdata)
# 
# Group by a number of different variables in the dataframe

ticketcount<-read.csv(file='tickcount.csv')

ticketcount$Related.Root.Configuration.Item.Application.Portfolio.Identifier<-as.factor(ticketcount$Related.Root.Configuration.Item.Application.Portfolio.Identifier)

ticketcount1<-subset(ticketcount, Incident.Created.Year.Month.Display.Code !="", drop = T)

ticketcount1<-drop.levels(ticketcount1)

appvector<-c(201759,201725,201727,201713,201710,201758,201760,201728,201724,201729,201726,201719)

ticketcount2<-subset(ticketcount1, ticketcount1$Related.Root.Configuration.Item.Application.Portfolio.Identifier %in% appvector, drop = T)

ticketcount2<-drop.levels(ticketcount2)

ticketcount2$NameandNumber<-paste(as.character(ticketcount2$Related.Root.Configuration.Item.Application.Portfolio.Identifier), as.character(ticketcount2$Related.Root.Configuration.Item.Business.Friendly.Name))

appnamenumbercombo <- unique(ticketcount2$NameandNumber)




shinyServer(function(input, output) {
  
  # get the input of the checkbox selections
  
  output$choose_apps <- renderUI({
    
    # Create the checkboxes and select them all by default
    checkboxGroupInput("checkGroup", "Choose Applications", 
                       choices  = appnamenumbercombo
                       )
  })
  
  ticketcount3 <- reactive({
   a <- subset(ticketcount2, ticketcount2$NameandNumber %in% input$checkGroup)
   a <- droplevels(a)
   return(a)
  })
 
  
  # For diagnostics  
  # output$text1 <- renderText({paste("this is text1:", input$checkGroup)})
  
   
  output$distPlot <- renderPlot({
    
    p<-ggplot(data = ticketcount3(), aes(x=Incident.Created.Year.Month.Display.Code, y=count, group=1)) + geom_line(aes(colour=Related.Root.Configuration.Item.Business.Friendly.Name, group=Related.Root.Configuration.Item.Business.Friendly.Name) )
    
    p+ylab("Number of monthly support tickets")+xlab("Year and Month")+labs(title="Tickets per month", colour="Application")
    
  })
  
})
