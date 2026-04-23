library(shiny)
library(tidyverse)
# other libraries here

# data loading and one-time processing here
data.pheno <- read_csv("RiceDiversity.44K.MSU6.Phenotypes.csv")

# Define UI for application 
ui <- fluidPage(
  
  titlePanel("[Placeholder]"),
  
  helpText("[Placeholder]"),
  
  sidebarLayout(
    sidebarPanel(
      radioButtons(
        "location",
        "Choose which location from which flowering time was recorded:",
        choices = c(
          "Flowering time at Arkansas",
          "Flowering time at Faridpur",
          "Flowering time at Aberdeen"
        )
      ),
      
      sliderInput(
        "seedlength",
        "Set length of seed:",
        min = min(data.pheno$`Seed length`, na.rm = TRUE),
        max = max(data.pheno$`Seed length`, na.rm = TRUE),
        value = c(
          min(data.pheno$`Seed length`, na.rm = TRUE),
          max(data.pheno$`Seed length`, na.rm = TRUE)
        )
      )
      
    ),
    
    mainPanel(
      plotOutput("histogram")  # also fixed extra space
    )
  )
)

# Define server logic 
server <- function(input, output) {
  
  # pivoting FT data for plot
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
  
  output$plot <- renderPlot(
    # get seed length
    plotseedlength <- input$seedlength
    
    #setup plot
    pl <- data.pheno.FT %>% 
      filter(location == as.name(input$location) %>% 
      ggplot(aes(x= plotseedlength, 
                 y= FT)) + geom_point() + 
        geom_smooth()
      )
  )
  
}
# Run the application 
shinyApp(ui = ui, server = server)