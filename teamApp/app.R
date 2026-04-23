library(shiny)
library(tidyverse)
# other libraries here

# data loading and one-time processing here
data.pheno <- read_csv("~/Assignments/assignment-04-ammoser/input/RiceDiversity.44K.MSU6.Phenotypes.csv")

# Define UI for application 
ui <- fluidPage( #create the overall page
    
  # Application title
  titlePanel("[Placeholder]"),
  
  # Application Summary
  helpText(""),
  
  # User sidebar
  sidebarLayout(
    sidebarPanel(
      
    )
  ),
  
  # Present Plot
  mainPanel(
    
  )
  )


# Define server logic 
server <- function(input, output) {
  # server code here
}

# Run the application 
shinyApp(ui = ui, server = server)
