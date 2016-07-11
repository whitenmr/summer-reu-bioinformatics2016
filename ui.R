#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)


shinyUI(
  navbarPage(inverse= TRUE, "Comprall", 
             tabPanel("Home", 
                      fluidPage(column(7, h3("Welcome to the webpage. This will give the user a chance to compare their data to other 
                                             users data or existing data on a database. This utilizes ADAM and R shiny. ")))
                      ),
             tabPanel("Upload", 
                      sidebarLayout(
                        sidebarPanel(
                          fileInput('file1', label=h5('Choose File'),
                                               accept=c('text/csv')),
                          checkboxInput("header", "Header", TRUE),
                          #UPLOAD A FILE HERE
                          radioButtons("dataType", "Data Type",
                                       c("CSV"= ",", "VCF"="\t", "TXT"= " ")
                          )
                         
                        ),
                        mainPanel(
                          tableOutput('contents')
                        )
                        
                      )),
             tabPanel("ADAM Options", fluidRow(column(4, h3("Here are all of the options of the things that you can do to your data. "), offset =2))
                      
             ),
             navbarMenu("More",
                        tabPanel("About",
                                 fluidPage(column(7, offset = 5, h1("Questions?")),  h3("What is ADAM?"), 
                                           p("ADAM is built on Spark and Avro and Parquet from Apache"),
                                           h3("Where can I find more about ADAM?"),
                                           a(href = "http://www.eecs.berkeley.edu/Pubs/TechRpts/2013/EECS-2013-207.pdf", "EECS on ADAM")))
                                 )
                          
                        )
                        
                        )
    
  




  
  
