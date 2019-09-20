library(shiny)
library(ggplot2)
library(caret)
library(randomForest)
library(e1071)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  ## General random forest model to predict species
  model1 <- train(Species ~ ., data=iris, method="rf")
  model2 <- train(Species ~ ., data=iris, method="rpart")
  
  ## Generate reactive prediction of species by slider inputs
  model1pred <- reactive({
      slInput <- input$slInput
      swInput <- input$swInput
      plInput <- input$plInput
      pwInput <- input$pwInput
      df <- data.frame(Sepal.Length = slInput,
                       Sepal.Width = swInput,
                       Petal.Length = plInput,
                       Petal.Width = pwInput)
      predict(model1, newdata = df)
  })
  
  model2pred <- reactive({
      slInput <- input$slInput
      swInput <- input$swInput
      plInput <- input$plInput
      pwInput <- input$pwInput
      df <- data.frame(Sepal.Length = slInput,
                       Sepal.Width = swInput,
                       Petal.Length = plInput,
                       Petal.Width = pwInput)
      predict(model2, newdata=df)
  })

  ## Render text for species prediction
  output$prediction1 <- renderText({paste("The predicted species from the random forest model is", 
                                         model1pred())})
  
  output$prediction2 <- renderText({paste("The predicted species from the classification tree model is",
                                          model2pred())})
  
  ## Render plot for sepal length, width for iris dataset and slider inputs
  sepalPoint <- reactive({
      slInput <- input$slInput
      swInput <- input$swInput
      data.frame(Sepal.Length=slInput, Sepal.Width=swInput)
  })
  
  output$sepalPlot <- renderPlot({
    ggplot(data=iris, aes(x=Sepal.Length, y=Sepal.Width, color=Species)) + 
          geom_point() +
          geom_point(data=sepalPoint(), aes(x=Sepal.Length, y=Sepal.Width, color="new flower")) +
          theme_classic()
  })
  
  ## Render plot for petal length, width for iris dataset and slider inputs
  petalPoint <- reactive({
      plInput <- input$plInput
      pwInput <- input$pwInput
      data.frame(Petal.Length=plInput, Petal.Width=pwInput)
  })
  
  output$petalPlot <- renderPlot({
      ggplot(data=iris, aes(x=Petal.Length, y=Petal.Width, color=Species)) + 
          geom_point() +
          geom_point(data=petalPoint(), aes(x=Petal.Length, y=Petal.Width, color="new flower")) +
          theme_classic()
  })

})
