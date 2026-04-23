library(shiny)
library(tidyverse)
# other libraries here

# data loading and one-time processing here
data.pheno <- read_csv("teamApp/RiceDiversity.44K.MSU6.Phenotypes.csv")

# Define UI for application 
ui <- fluidPage( #create the overall page
    #UI code here
  )


# Define server logic 
server <- function(input, output) {
  # server code here
  
  # pivoting FT data for histogram
  data.pheno.FT <- data.pheno %>% 
    select('Region', 
           'Flowering time at Arkansas',
           'Flowering time at Faridpur',
           'Flowering time at Aberdeen',
           'Seed length') %>% 
    pivot_longer(cols = c(-'Region',-'Seed length'),
                 names_to = 'location',
                 names_prefix = 'Flowering time at ',
                 values_to = 'FT')
  
  
}

# Run the application 
shinyApp(ui = ui, server = server)
