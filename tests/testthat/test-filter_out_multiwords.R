test_that("artificial tokens are removed", {
  expect_equal(nrow(filter_out_multiwords(two_multitokens)), 7)
  expect_equal(nrow(filter_out_multiwords(other_two_multitokens)), 13)
})
