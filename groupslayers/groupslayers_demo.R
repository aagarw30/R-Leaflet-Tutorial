## Demo layers and groups
## 
##

## Load the leaflet package
## We will use the quakes dataset for the sake of demo

library(leaflet)
leaflet(data=quakes) %>% 
  addTiles(group="OSM") %>% # added a base tile 
  addProviderTiles("Stamen.Toner", group="Toner") %>%  # added 3rd party provider tiles
  addProviderTiles("Stamen.TonerLite", group="Toner Lite") %>%  # added 3rd party provider tiles
  addMarkers(lng=~long, lat=~lat, group ="Markers") %>% # add markers
  addCircleMarkers(lng=~long, lat=~lat, group ="Circle Markers") %>%  # add circle markers
  # Now adding the control for layers
  # Define what constitues the base group and overlay groups
  addLayersControl(
    baseGroups = c("OSM", "Toner", "Toner Lite"),
    overlayGroups = c("Markers",  "Circle Markers"),
    options = layersControlOptions(collapsed = FALSE) # control options remains on the map
  ) %>% 
  hideGroup("Markers") # if you want the Markers group to be unchecked initially. Basically, hides the group