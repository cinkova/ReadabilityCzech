test_that("it sums all multiword tokens and subtracts them from the total number of rows", {
  expect_equal(count_words_in_conllu(two_multitokens), 5)
  expect_equal(count_words_in_conllu(other_two_multitokens), 10)
})
