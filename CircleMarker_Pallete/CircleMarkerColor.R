## Demo - Add Circle Markers with different colors based on factor variable
## We will use the quakes data for demo and maping

# Load the required packages
library(leaflet)
set.seed(122)
# Sample the data for 50 observations
quakes1=quakes[sample(nrow(quakes),50),]

# create earthquake magnitude range to define the type as follows 
quakes1$magrange = cut(quakes1$mag, 
                      breaks = c(4, 5, 6, 7), right=FALSE,
                      labels = c("Light[4-5)", "Moderate[5-6)", "Strong[6-7)"))

# Define a color pallete corresponding to the magnitude ranges
pal = colorFactor(palette = c("yellow", "red", "black"), domain=quakes1$magrange)

# Create the map object & add circle marker
leaflet(data=quakes1) %>% 
  addProviderTiles("Esri.WorldImagery") %>% 
  addCircleMarkers(lng = ~ long, 
                   lat= ~ lat, 
                   color = ~ pal(magrange), #use the pallete
                   label = paste("Magnitude=", quakes1$mag, "Type=", quakes1$magrange)

                   )

