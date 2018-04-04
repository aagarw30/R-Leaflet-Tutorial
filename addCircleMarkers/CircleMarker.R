## Add Circle Markers Demo
## addCircleMarkers() function
## We will use the quakes data for demo and maping

# Load the required packages
library(leaflet)

# Sample the quakes data with 10 data points to avoid cluttering
quakes1 = quakes[sample(nrow(quakes), 10), ]

# Create the map object & add circle marker
leaflet(data=quakes1) %>% # initialize the map object
  addProviderTiles("Esri.WorldImagery") %>%  # add 3rd party map base tile
  # addMarkers(lng = ~ long, lat=~ lat) %>% 
  addCircleMarkers(lng = ~ long, 
                   lat= ~ lat) # add Circle Markers


