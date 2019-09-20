library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Iris Species Prediction"),

  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       h5("Simply move the sliders.  The application will predict 
          the species based on the slider values using random forest 
          and classification tree models using the caret and randomForest packages.  Enjoy!"),
       sliderInput("plInput",
                   "Petal Length:",
                   min = min(iris$Petal.Length),
                   max = max(iris$Petal.Length),
                   value = mean(iris$Petal.Length)),
       sliderInput("pwInput",
                   "Petal Width:",
                   min = min(iris$Petal.Width),
                   max = max(iris$Petal.Width),
                   value = mean(iris$Petal.Width)),
       sliderInput("slInput",
                   "SepalLength:",
                   min = min(iris$Sepal.Length),
                   max = max(iris$Sepal.Length),
                   value = mean(iris$Sepal.Length)),
       sliderInput("swInput",
                   "Sepal Width:",
                   min = min(iris$Sepal.Width),
                   max = max(iris$Sepal.Width),
                   value = mean(iris$Sepal.Width))
       
    ),
    
    # Show the outputs
    mainPanel(
       textOutput("prediction1"),
       textOutput("prediction2"),
       plotOutput("petalPlot"),
       plotOutput("sepalPlot")
       
    )
  )
))
