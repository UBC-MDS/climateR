context("Testing suntime()")

city <- "Istanbul"
correct_output <- suntime(city)

test_that("Inputs are correct", {
  expect_error(typeof(city), 'string')
})

test_that("Outputs are correct", {
  expect_match()
  expect_equal()

})
