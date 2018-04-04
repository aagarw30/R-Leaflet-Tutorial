######### Add Circle to R Leaflet map ##########
library(leaflet) # Load the leaflet package

# Read the data from .csv file
cities = read.csv("pop.csv")

# head(cities)
# str(cities)
# View(cities)

# Using addCircles() function add the circles
# it needs the center and radii
# center is defined by lat, long values
# radii is in meters

leaflet(data=cities) %>% 
  addTiles() %>%
  addCircles(lng = ~Long, 
             lat = ~Lat, 
             weight = 5,
             radius = ~sqrt(Pop) * 30, 
             popup = ~City,
             #fillColor = "red",
             fillColor = "transparent",
             highlightOptions = highlightOptions(
                                                 weight = 10, 
                                                 color = "brown", 
                                                 fillColor = "green"),
             label = ~City
             
  )
