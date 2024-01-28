test_that("df with syllable counts is generated ", {
  expect_equal(create_syllablecount_per_token_df(two_multitokens)$syllables, c(2,1,1,3,3))
})


