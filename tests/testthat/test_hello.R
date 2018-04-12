context("hello.R")

test_that("Expected outputs are correct - hello", {

  x <- hello()

  expect_equal(typeof(x), "character")

})
