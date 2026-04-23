#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)
library(tidyverse)

data(iris)

# Define UI for application that draws a box plot
ui <- fluidPage( #create the overall page
    
    # Application title
    titlePanel("Iris Data"),
    
    # Some helpful information
    helpText("This application creates a violin plot to show the traits of",
             "one iris species.  Please use the radio box below to choose a species",
             "for plotting"),
    
    # Sidebar with a radio box to input which trait will be plotted
    sidebarLayout(
      sidebarPanel(
        radioButtons("species", #the input variable that the value will go into
                     "Choose a species to display traits:",
                     c("setosa",
                       "versicolor",
                       "virginica")
        )),
      
      # Show a plot of the generated distribution
      mainPanel(
        plotOutput("violinPlot")
      )
    )
  )


# Define server logic required to draw a box. plot
server <- function(input, output) {
  
  # Expression that generates a boxplot. The expression is
  # wrapped in a call to renderPlot to indicate that:
  #
  #  1) It is "reactive" and therefore should re-execute automatically
  #     when inputs change
  #  2) Its output type is a plot
  
  output$violinPlot <- renderPlot({
    
    plotSpecies <- as.name(input$species) # convert string to name
    
    # Reformat iris data into long format
    iris_longer <- iris %>% 
      filter(Species = input$Species) %>% 
      pivot_longer(
        cols = -Species,
        names_to = "trait",
        values_to = "value"
      )
    
    # set up the plot
    pl <- ggplot(data = iris_longer,
                 aes(x=!! plotSpecies, # !! to use the column names contained in plotSpecies
                     y= trait,
                     fill=trait

                 )
    )
    
    # draw the boxplot for the specified trait
    pl + geom_violin()
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
