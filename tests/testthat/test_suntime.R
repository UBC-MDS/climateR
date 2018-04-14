context("suntime.R")

city <- "Istanbul"
correct_output <- suntime(city)


test_that("Inputs are correct", {
  expect_equal(typeof(city), 'character') # type of a city input must be a string
  expect_error(suntime(city = 5))
  expect_error(suntime(city = "A."))
})

test_that("Outputs are correct", {
  expect_match(typeof(correct_output), 'list') # type of the output must be a list
  expect_equal(length(correct_output), 3) # length  of the output list must be 4
})
