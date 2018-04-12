# test_get_past_info.R
# April 2018
#
# This script tests the function from get_past_info.R.

### Test get_past_info function

## Computes the minimum, maximum temperature, average wind speed, average humidity for a given past date

context("Testing get_past_info()")

my_city <- "Istanbul"
past_day <- "2017/8/30/"

# get past information for
info_list <- getpastinfo(my_city, past_day)

test_that("Testing getpastinfo", {

  # input type:
  expect_match(typeof(my_city), 'string')  # type of a city input must be a string
  expect_match(typeof(past_day), 'string') # type of a date input must be a string

  expect_error(getpastinfo(city_name = 5, "2017/8/30/"))
  expect_error(getpastinfo(city_name = "Istanbul", date = 2017830))

  # output type and shape:
  expect_match(typeof(info_list), 'list') # type of the output must be a list
  expect_equal(length(info_list),4) # length  of the output list must be 4


})
