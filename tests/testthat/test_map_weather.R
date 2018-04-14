# test_map_weather.R
# April 2018
#
# This script tests the function from map_weather.R.

### Test map_weather function

## Plots weather state for current date.

continent <-  "Africa"
output <- get_weather(cities = "Paris",continent = "Europe")

test_that("Continent and Cities are character strings", {
  expect_match(typeof(continent), 'character') # type of a continent input must be a string
  expect_error(get_weather(cities = 44,continent = "Africa"))
  expect_error(get_weather(cities = "Vancouver",continent = 11))
  expect_error(get_weather(cities = "Vancouver",continent = "Antarctica"))

})


test_that("Check output", {
expect_match(typeof(output), 'list') # type of a continent input must be a string
})
