library(httr)
library(installr)
library(stringr)
library(ggplot2)
library(ggmap)


#Wrapper function
get_weather <- function(cities,continent){

  # Plots weather state for current date.
  # Input: cities: vector of cities (same continent)
  # Input: continent: (String )continent corresponding to city_name
  # Output: continent map for given cities

  #Error handling
  if (!is.character(cities))
    stop("Need to input an string.")
  if (!is.character(continent))
    stop("Need to input an string.")
  if (!(continent %in% c("Asia","Africa","Australasia","Europe","North America","South America")))
    stop("Continent can only be one of Asia, Africa, Australasia, Europe, North America, South America ")

  #Base query
  query_base <- "https://www.metaweather.com/api/"

  search_location=c()
  woeid = c()
  lat_long = c()
  coord = c()
  lat = c()
  lon =c()
  search_temp =c()
  ws_name =c()
  city_name =c()

  #Retrieve where on earth id  and coordinates of city through API
  for (i in 1:length(cities)){
    print(cities[i])
    search_location[i] <- content(GET(paste0(query_base,"location/search/?query=",cities[i])))
    woeid[i] <- search_location[[i]]$woeid
    lat_long[i] <- search_location[[i]]$latt_long
    coord[i] <- str_split(lat_long[i],",")
    lat[i] <- as.numeric(coord[i][[1]][1])
    lon[i] <- as.numeric(coord[i][[1]][2])

    search_temp <- content(GET(paste0(query_base,"location/",woeid[i],"/")))
    ws_name[i] <- search_temp[[1]][[1]]$weather_state_name
    city_name[i] <- cities[i]
    df <- as.data.frame(cbind(city_name,lon,lat,ws_name))
  }
  #Plot location of city on Map
  #Get map to use as base map
  map <- get_map(location = continent, zoom = 3)
  loc_map <- ggmap(map)+
    geom_point(data = df, aes(x = as.numeric(as.character(lon)), y = as.numeric(as.character(lat)),color=ws_name), size = 3, shape = 17) +
    geom_text(data = df, aes(x = as.numeric(as.character(lon)), y = as.numeric(as.character(lat)), label=city_name,vjust = 0.05, hjust = -0.1),fontface="bold",size=3)+
    scale_color_brewer("Weather state",palette = "Dark2")
  return(loc_map)
}
