test_that("multiplication works", {
  expect_equal(2 * 2, 4)
})

test_that("it counts sentences", {
  expect_equal(count_sentences_in_conllu(text_Vese), 19)
  
})
