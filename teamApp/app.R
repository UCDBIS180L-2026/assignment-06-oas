library(shiny)
library(tidyverse)
# other libraries here

# data loading and one-time processing here
data.pheno <- load("~/Assignments/assignment-04-shbaweja-ux/input/RiceSNPData/RiceDiversity.44K.MSU6.Phenotypes.csv")

# Define UI for application 
ui <- fluidPage( #create the overall page
    #UI code here
  )


# Define server logic 
server <- function(input, output) {
  # server code here
}

# Run the application 
shinyApp(ui = ui, server = server)
