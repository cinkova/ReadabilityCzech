test_that("multiplication works", {
  expect_equal(2 * 2, 4)
})

test_that("diphthongs and prefix + u-stem are recognized in common words",
          {expect_equal(count_czech_syllables("poučený"), 4)
            expect_equal(count_czech_syllables("pomoučený"), 4)
            expect_equal(count_czech_syllables("nauka"), 3)
            expect_equal(count_czech_syllables("nauka"), 3 )## should have 3 syllables: found in lexicon
            expect_equal(count_czech_syllables("pavouk"),2) ## should have 2 syllables: ou is a diphthong
            expect_equal(count_czech_syllables("polousazeni"), 6) ## should have 6 syllables:
            expect_equal(count_czech_syllables("brouka"), 2)
          })
test_that("r and l form a vowel",{
expect_equal(count_czech_syllables("zmrzl"), 2)
}
          )


