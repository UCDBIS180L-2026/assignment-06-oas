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
  
  output$histogram <- renderPlot(
    
    #setup line plot
    pl <- data.pheno.FT %>% 
      filter(location == as.name(input$location) %>% 
<<<<<<< HEAD
               ggplot(aes(x= `Seed Length`, 
                          y= FT)) + 
               geom_line()
=======
      ggplot(aes(x= `Seed length`, 
                 y= FT)) + geom_point() + 
        geom_smooth()
>>>>>>> de8c2c181d9d941a73676164b45fdb92ad07f6db
      )
  )
  
}
# Run the application 
shinyApp(ui = ui, server = server)