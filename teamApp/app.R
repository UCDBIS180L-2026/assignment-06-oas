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
  output$histogram <- renderPlot(
    
    #setup line plot
    pl <- data.pheno.FT %>% 
      filter(location == as.name(input$location) %>% 
      ggplot(aes(x= `Seed Length`, 
                 y= FT)) + geom_line()
    
  )
  # server code here
)
}
# Run the application 
shinyApp(ui = ui, server = server)
