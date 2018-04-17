## Updating the R Leaflet map without using leaflet proxy
library(shiny)
library(leaflet)

ui <- bootstrapPage(
  tags$style(type = "text/css", "html, 
              body {width:100%;height:100%}"),
  leafletOutput("map", width= "100%", height = "100%"),
  
  absolutePanel(top = 20, right = 50,
    sliderInput("range", "Select the Magnitude Range", min = min(quakes$mag), max =max(quakes$mag), step = 0.10, value=range(quakes$mag))
  )
  
)

server <- function(input, output, session){
  
  ## Filter the quakes data based on the earthquake magnitude range selected by user
  filtered <- reactive({
        quakes[quakes$mag>= input$range[1] & quakes$mag<=input$range[2], ]
  })
  
  ## Mapping the data
  output$map <- renderLeaflet({
    leaflet(data=filtered()) %>% 
      addTiles() %>% 
      addMarkers()
      
  })
  
}

shinyApp(ui=ui, server=server)