test_that("average token length in syllables", {
  expect_equal(count_average_token_length_in_syllables(two_multitokens), 2)
})
