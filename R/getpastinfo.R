#' getpastinfo: Minimum, maximum temperatures, average wind speed, and average humidity for a given date of a particular city
#'
#' @importFrom httr
#'
#' @param city_name string value
#'
#' @param date string value
#'
#' @return list of minimum, maximum temperatures, average wind speed, and average humidity for a given past date
#'
#' @export
#'
#' @examples
#' getpastinfo("London","2013/4/27/")
#'
#'


getpastinfo <- function(city_name ="London", date = "2013/4/27/"){
  # Computes minimum, maximum temperatures, average wind speed, and average humidity for a given date of a particular city
  # Input: city_name: (String) name of a city
  # Input: data: (String) request date
  # Output : list of minimum, maximum temperatures, average wind speed, and average humidity

  #Error handling
  if (!is.character(city_name))
    stop("Need to input an string.")
  if (!is.character(date))
    stop("Need to input an string.")

  query_base <- "https://www.metaweather.com/api/"
  #Retrieve where on earth id  and coordinates of city through API
  search_location <- content(GET(paste0(query_base,"location/search/?query=",city_name)))

  if (length(search_location) == 0)
    stop("This city does not exist.")

  woeid <- search_location[[1]]$woeid
  past_info_cont <- content(GET(paste0(query_base,"/location/",woeid,"/",date)))

  if (length(past_info_cont) == 0)
    stop("please, check date input!")


  realized_min_temp <- past_info_cont[[1]]$min_temp
  realized_max_temp <- past_info_cont[[1]]$max_temp

  windspd = c()
  humid = c()
  for(i in 1:length(past_info_cont)){
    windspd <- append(windspd,  past_info_cont[[i]]$wind_speed)
    humid <-   append(humid,  past_info_cont[[i]]$humidity)
  }


  avg_wind_speed <- round(mean(windspd, na.rm = TRUE),2)
  avg_humidity <- round(mean(humid, na.rm = TRUE),2)

  return(list(min_temp = realized_min_temp,max_temp =realized_max_temp, windspeed = avg_wind_speed, humidity =avg_humidity))

}
