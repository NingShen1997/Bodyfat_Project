library(shiny)
library(shinyWidgets)

ui <- fluidPage(
  
  setBackgroundColor(
    color = c("#F7FBFF", "#2171B5"),
    gradient = "linear",
    direction = "bottom"
  ),
  
  titlePanel("Bodyfat Calculator"), 
  
  sidebarPanel(
    h2("imput your body stats"),
    div(style="display: inline-block;vertical-align:top; width: 200px;",numericInput(inputId ="weight", label = h3("Weight"),150,min=0,max=500)),
    div(style="display: inline-block;vertical-align:top; width: 70px;",HTML("<br>")),
    div(style="display: inline-block;vertical-align:top; width: 190px;",selectInput(inputId = "weightMeasure", label=h3("kg/lbs"), choices=c("kg","lbs"),selected="lbs")),
    
    div(style="display: inline-block;vertical-align:top; width: 200px;",numericInput("abdomen", label = h3("Abdomen"),85,min=0,max=300)),
    div(style="display: inline-block;vertical-align:top; width: 70px;",HTML("<br>")),
    div(style="display: inline-block;vertical-align:top; width: 190px;",selectInput(inputId = "abdomenMeasure", label=h3("cm/inches"), choices=c("cm","inches"),selected="cm")),
    
    width=7
  ),
  
  
  sidebarPanel(
    h3("Here is your Bodyfat !"),
    textOutput("value"),
    width=7
  )
)

server <- function(input, output) {
  
  x1<-reactive(return(ifelse(input$weightMeasure == "kg",FALSE,TRUE)))
  x2<-reactive(return(ifelse(input$abdomenMeasure == "inches",FALSE,TRUE)))
  y1<-reactive(if(x1()==FALSE) return(2.2046*input$weight) else return(input$weight))
  y2<-reactive(if(x2()==FALSE) return(2.54*input$abdomen) else return(input$abdomen))
  z<-reactive(return(-0.12*y1()+0.9*y2()-42))
  
  output$value = renderText({z()})
}

shinyApp(ui = ui, server = server)
