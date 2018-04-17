## Demo leafletProxy()
## Updating the R Leaflet map using leaflet proxy
## update the markers based on the earthquake magnitude range selected by user

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
  
  
  ## Put the initial static content along with leaflet the way it should appear initially
  output$map <- renderLeaflet({
    leaflet(data=quakes) %>% 
      addTiles() %>% 
      addMarkers()
      
    
  })

  ## Put the dynamic content along with leafletproxy to make updates to the map
  ## On change of range slider input, data subset will change
  ## Leaflet proxy updates the map without re-creating the map from scratch
  ## Clear the previous markers
  ## add new markers based on the new subset data 
  observe(leafletProxy("map", data=filtered()) %>%
            clearMarkers() %>%
            addMarkers()
  )
  
  ## Below lines of code if you want to use observeEvent with leafletProxy
  # observeEvent(input$range,
  #              leafletProxy("map", data=filtered()) %>%
  #                clearMarkers() %>%
  #                addMarkers()
  #              )
  

  
}

shinyApp(ui=ui, server=server)