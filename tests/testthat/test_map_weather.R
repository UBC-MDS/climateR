# test_map_weather.R
# April 2018
#
# This script tests the function from map_weather.R.

### Test map_weather function

## Plots weather state for current date.

test_that("Continent and Cities are character strings", {
  expect_match(typeof(continent), 'character') # type of a continent input must be a string
  expect_error(get_weather(cities = 44,continent = "Africa"))
  expect_error(get_weather(cities = "Vancouver",continent = 11))

})


test_that("Check output", {
expect_match(typeof(get_weather(cities = "Cairo",continent = "Africa")), 'list') # type of a continent input must be a string
expect_match(length(get_weather(cities = "Cairo",continent = "Africa")), 9)
})
