test_that("divides tokens by sentences", {
  expect_equal(count_average_sentence_length(two_multitokens), 2.5)
})

