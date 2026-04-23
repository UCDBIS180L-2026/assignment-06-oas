library(shiny)
library(tidyverse)
# other libraries here

# data loading and one-time processing here
data.pheno <- read_csv("RiceDiversity.44K.MSU6.Phenotypes.csv")

# Define UI for application 
ui <- fluidPage( #create the overall page
    
  # Application title
  titlePanel("[Placeholder]"),
  
  # Application Summary
  helpText(""),
  
  # User sidebar
  sidebarLayout(
    sidebarPanel(
      # Radio box to input which specific location flowering times were recorded: Arkansas, Faridpur, or Aberdeen
      radioButtons(
        "location", # input variable for location
        "Choose which location from which flowering time was recorded:",
        c(
          "Flowering time at Arkansas",
          "Flowering time at Faridpur",
          "Flowering time at Aberdeen"
        ),
      # Slider for seed length
      sliderInput(
        "seedlength", # input variable for seed length
        "Set length of seed:",
        min = min(data.pheno$`Seed length`, na.rm = TRUE),
        max = max(data.pheno$`Seed length`, na.rm = TRUE),
        value = c(min(data.pheno$`Seed length`, na.rm = TRUE), max(data.pheno$`Seed length`, na.rm = TRUE))
      )
      )
    )
  ),
  
  # Present Plot
  mainPanel(
    plotOutput("boxPlot")
  )
  )


# Define server logic 
server <- function(input, output) {
  # server code here
}

# Run the application 
shinyApp(ui = ui, server = server)
