#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
#

library(shiny)
library(AppliedPredictiveModeling)
library(caret)
library(kernlab)
data(concrete)

# Define server logic 
shinyServer(function(input, output) {
  
  # Data partition. Get a training and testing data set. This process is not necessary
  # since the testing data set is never used
  
  inTrain=createDataPartition(mixtures$CompressiveStrength,p=3/4, list=FALSE)
  training=mixtures[inTrain,]
  testing=mixtures[-inTrain,]
  
  # Build two models, generalized linear model and generalized boosted model
  
  model1 <- train(CompressiveStrength ~ ., method = "glm", data = training)
  model2 <- train(CompressiveStrength ~ ., method = "gbm", data = training)
  model1pred <- reactive({
  Input1 <- input$slider
  Input2 <- 0.787-Input1
  predict(model1, newdata = data.frame(Cement=0.12,BlastFurnaceSlag=0.01,FlyAsh=0,Water=0.08,Superplasticizer=0.003, CoarseAggregate=Input1, FineAggregate=Input2, Age=40))
 })
 
  
  model2pred <- reactive({
    Input1 <- input$slider
    Input2 <- 0.787-Input1
    predict(model2, newdata = data.frame(Cement=0.12,BlastFurnaceSlag=0.01,FlyAsh=0,Water=0.08,Superplasticizer=0.003, CoarseAggregate=Input1, FineAggregate=Input2, Age=40))
  })
  
  
  # Text outputs
  
  output$pred1 <- renderText({
    if(input$showModel1){
      model1pred()
    }
    
  })

  output$pred2 <- renderText({
    if(input$showModel2){
      model2pred()
    }
  })
  
  # Barplot output
  
  output$plot1 <- renderPlot({
    if(input$showModel1){
      barplot(c(model1pred(),0), names.arg=c("Generalized Linear Model", "Generalized Boosted Model"), ylim=c(0,40), col=c("orange"))
    }
    if(input$showModel2){
      barplot(c(0,model2pred()), names.arg=c("Generalized Linear Model", "Generalized Boosted Model"), ylim=c(0,40), col=c("orange"))
    }
    if(input$showModel1&input$showModel2){
    barplot(c(model1pred(),model2pred()), names.arg=c("Generalized Linear Model", "Generalized Boosted Model"), ylim=c(0,40), col=c("orange"),lwd=2)
    }
      })
  
})
