#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# This application builds generalized linear model and generalized boosted model
# on the "concrete" data set described by Yeh(1998). Then it can predict the 
# compressive strength of concrete for different proportions of cement, coarse 
# aggregate and fine aggregate assuming specific values for other variables
#


library(shiny)

# Define UI for application 
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Compressive Strength of Concrete from Yeh (1998)"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      
      # There are eight predictors. For the final test examples, we assume specific values
      # for five variables. This choice is convenient because we must guaratine that the 
      # proportions of the values of variables must add up to one.
      
      h4("Suppose the proportions of some ingredients of the concrete we have are the following"),
      h4("Cement: 0.12"),
      h4("BlastFurnaceSlag: 0.01"),
      h4("FlyAsh: 0"),
      h4("Water: 0.08"),
      h4("Superplasticizer: 0.003"),
      h4("Age: 40"),
      h4("Other ingredients are CoarseAggregate and FineAggregate"),
      sliderInput("slider", "What is the proportion of CoarseAggregate?", 0.3, 0.5, value = 0.4),
      checkboxInput("showModel1", "Show/Hide Generalized Linear Model", value = TRUE),
      checkboxInput("showModel2", "Show/Hide Generalized Boosted Model", value = TRUE)
    ),
    
    # Show the results by using a plot and texts
    mainPanel(
      plotOutput("plot1"),
      h3("Predicted Compressive Strength from Generalized Linear Model"),
      textOutput("pred1"),
      h3("Predicted Compressive Strength from Generalized Boosted Model"),
      textOutput("pred2")
    )
  )
))
