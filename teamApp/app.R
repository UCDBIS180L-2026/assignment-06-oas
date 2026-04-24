library(shiny)
library(tidyverse)
# other libraries here

# data loading and one-time processing here
data.pheno <- read_csv("RiceDiversity.44K.MSU6.Phenotypes.csv")

# Define UI for application 
ui <- fluidPage(
  
  titlePanel("Rice Seed Length vs. Flowering Time"),
  
  helpText("This application creates a line plot with a trendline to show the",
           "change in flowering time based on location and seed length.",
           "Feel free to use the radio box below to select a location and",
           "the slider to set the range of seed lengths to view."),
  
  sidebarLayout(
    sidebarPanel(
      radioButtons( # Arden: Radio button to allow user to select location where flowering time was recorded
        "location",
        "Choose which location from which flowering time was recorded:",
        choices = c(
          "Arkansas",
          "Faridpur",
          "Aberdeen"
        )
      ),
      
      sliderInput( # Arden: Slider to allow user to set range of seed length
        "seedlength",
        "Set length of seed:",
        min = round(min(data.pheno$`Seed length`, na.rm = TRUE), 2),
        max = round(max(data.pheno$`Seed length`, na.rm = TRUE), 2),
        value = c(
          min(data.pheno$`Seed length`, na.rm = TRUE),
          max(data.pheno$`Seed length`, na.rm = TRUE)
        )
      )
      
    ),
    
    mainPanel(
      plotOutput("plot")  # also fixed extra space
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
  
  output$plot <- renderPlot({
    
    #setup plot
    pl <- data.pheno.FT %>%
      filter(
        location == input$location,
        `Seed length` >= input$seedlength[1],
        `Seed length` <= input$seedlength[2]
      ) %>% 
      ggplot(aes(x = `Seed length`, y = FT))
      
      #draw plot
      pl + geom_point() + 
        geom_smooth(method = "lm", se = FALSE) +
        labs(x = 'Seed Length', y = 'Flowering Time') +
        theme(base_size = 16,
              axis.title.x = element_text(face = 'bold'),
              axis.title.y = element_text(face = 'bold'))
    
  })
  
}
# Run the application 
shinyApp(ui = ui, server = server)