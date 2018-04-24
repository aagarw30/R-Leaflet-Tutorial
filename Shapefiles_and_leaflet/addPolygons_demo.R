## Demo - Shape files and R Leaflet
## Add shapes to R leaflet map using addPolygons() functions
## Draw the boundaries on world map. Required geometry will come from shape files and then we will use them for maping


## Source of shape file
# http://thematicmapping.org/downloads/world_borders.php

## Set working directory ## 
## Download the shape files to working directory ##
download.file("http://thematicmapping.org/downloads/TM_WORLD_BORDERS_SIMPL-0.3.zip" , destfile="TM_WORLD_BORDERS_SIMPL-0.3.zip")
## Unzip them ##
unzip("TM_WORLD_BORDERS_SIMPL-0.3.zip")

## OR ## You can directly connect to download link and download to a temp folder as well ##

## Load Required Packages## 
library(leaflet)
library(rgdal) # R 'Geospatial' Data Abstraction Library. Install package if not already installed.


## Load the shape file to a Spatial Polygon Data Frame (SPDF) using the readOGR() function
myspdf = readOGR(dsn=getwd(), layer="TM_WORLD_BORDERS_SIMPL-0.3")
head(myspdf)
summary(myspdf)

# using the slot data
head(myspdf@data)

## Create map object and add tiles and polygon layers to it
leaflet(data=myspdf) %>% 
  addTiles() %>% 
  setView(lat=10, lng=0 , zoom=2) %>% 
  addPolygons(fillColor = "green",
              highlight = highlightOptions(weight = 5,
                                           color = "red",
                                           fillOpacity = 0.7,
                                           bringToFront = TRUE),
              label=~NAME)
