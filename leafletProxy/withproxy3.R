## Demo leafletproxy() & marker click event
## Introducing removeMarker() function
## Use Case - remove specific markers on a click 
## For the sake of demo, we will use the quakes dataset and first 10 observations only


## Load required packages
library(shiny)
library(leaflet)

# Create layer ID for the markers - a character vector with 10 elements corresponding to the 10 markers
ID = paste("Marker", seq(1, 10, by = 1))

## ui code starts here
ui <- bootstrapPage(
  tags$style(type = "text/css", "html, 
             body {width:100%;height:100%}"),
  h5("Demo - Leaflet Marker Click Event. Using leafletProxy() & removeMarker() to  remove specific marker based on click event"),
  verbatimTextOutput("message"),
  leafletOutput("map1", width= "100%", height = "100%")
  

)


## server code starts here
server <- function(input, output, session) {
  
  ## Static aspects goes with leaflet()
  output$map1 <- renderLeaflet({
    leaflet(data=head(quakes, 10)) %>% 
      addTiles() %>% 
      addCircleMarkers(
      lng = ~long,
      lat = ~lat,
      layerId = ID,
      label = paste("LayerID=", ID, sep="")
      )
  })
  
  # Dynamic aspects or updates that is needed should go along leafletProxy()
  # Event/Input syntax input$Mapobject_OBJcategory_Eventname
  # input$map1_marker_click -> marker click event
  # input$map1_marker_click$id -> returns the ID of the marker that is clicked. This is used by removeMarker()
  
  observe(
    leafletProxy("map1") %>%
      removeMarker(input$map1_marker_click$id)
    
  )
  
  
  ## Printing message with layerID of the marker
  observe(
          if(is.null(input$map1_marker_click))
        return()
      else
        output$message <- renderText({
          paste("Marker with ID" , input$map1_marker_click$id, "removed", sep=" ")
          })
        )
  
  
}

shinyApp(ui, server)