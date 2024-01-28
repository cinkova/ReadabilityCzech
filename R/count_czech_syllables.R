#'Count Czech Syllables
#'
#'Takes a Czech word and counts syllables.
#'
#'This function counts syllables in a Czech word. The text must be encoded in UTF-8. The syllable is mostly defined either as a single vowel or the diphthongs "au" and "ou". Since not all sequences of "au" and "ou" are diphthongs, the function uses a built-in lexicon of stemmed words starting with "u". Besides, the function checks for frequent compounds ending with "o", such as "samo" (e.g. "samouk"), "celo", "velko", "rychlo",  and a few others. Other cases considered are the Czech syllabic "l" or "r"; e.g. in "mrkl" (he blinked), and the German diphthong "ei". On the other hand, the German "ie" remains two syllables, as it is  pronounced in Czech (loan) words (e.g. "Marie", "historie"). Non-syllabic tokens except punctuation, such as digits or symbols, count as monosyllabic.
#'
#' @param token character string, character vector. Must be encoded in UTF-8.
#'
#' @author Silvie Cinkova
#'
#' @import dplyr
#' 
#' @importFrom stringi stri_unescape_unicode
#' 
#' @import stringr
#'
#' @return numeric value
#' 
#' @export
#'
#' @examples
#' \dontrun{
#' count_czech_syllables("nauka") ## should have 3 syllables: found in lexicon
#' 
#' count_czech_syllables("pavouk") ## should have 2 syllables: ou is a diphthong
#' 
#' count_czech_syllables("polousazeni") ## should have 6 syllables: ou is not 
#' 
#' a diphthong, since the word is a compound with the first member listed
#' }
#' 
#' @details
#' This lexicon was extracted from the Czech National Corpus (Araneum Bohemicum Maximum, Capek complete, and SYN Version 11), stemmed, and overtly manually cleaned. The searches targeted lemmas starting with "u" and were complemented by searches for lemmas where "u" was preceded by potential prefixes e.g.("na, za, pro, po, do"). If your Czech text has been stripped of diacritics, the lexicon-based de-diphtongization will be less sensitive. Not completely eliminated though, since the corpus returned a non-trivial amount of diacritics-less matches, and these were not deliberately removed.
#'
count_czech_syllables <-
function(token){
token <- token
a <- stringr::str_count(string = tolower(token),
                        pattern = str_c("[a",stri_unescape_unicode("\\u00e1\\u00e4"), "](?![u])"))
o <- stringr::str_count(string = tolower(token),
                        pattern = str_c("[o", stri_unescape_unicode("\\u00f3\\u00f6"), "](?![u])"))
e <- stringr::str_count(string = tolower(token),
                        pattern = str_c("[e",
                                        stri_unescape_unicode("\\u00e9"),
                                        stri_unescape_unicode("\\u00e8"),
                                        stri_unescape_unicode("\\u011b"),
                                        stri_unescape_unicode("\\u00eb"),
                                        "](?![i])"))
i <- stringr::str_count(string = tolower(token),
                        pattern = str_c("(?<!e)[i",
                                        stri_unescape_unicode("\\u00ed"),
                                        "]"))
y <- stringr::str_count(string = tolower(token),
                        pattern = str_c("(?<!e)[y",
                                        stri_unescape_unicode("\\u00fd"),
                                        "]"))
u <- stringr::str_count(string = tolower(token),
                        pattern = str_c("(?<![ao])[u",
                        stri_unescape_unicode("\\u00fa"),
                        stri_unescape_unicode("\\u016f"),
                                        "]"))
ei <- stringr::str_count(string = tolower(token), pattern = "ei")
pbtdkghszflr <- stringr::str_count(string = tolower(token),
                                  pattern = str_c("[pbtdkghszfvmn",
                                  stri_unescape_unicode("\\u0161"),
                                  stri_unescape_unicode("\\u017e"),
                                                  "][lr](?![a","\\u00e1",
                                  "e", stri_unescape_unicode("\\u00e9\\u011b"),
                                  "i", stri_unescape_unicode("\\u011b"),
                                  "o", stri_unescape_unicode("\\u00f3\\u00f6"),
                                  "u", stri_unescape_unicode("\\u00fc\\u016f\\u00fa\\u00fc"),
                                  "y",
                                  stri_unescape_unicode("\\u00fd"),"])"))
oau <- stringr::str_count(string = tolower(token),
                          pattern = str_c("[ao",
                                          stri_unescape_unicode("\\u00e1\\u00f3"),
                                          "](?=[u])"))

is_in_ustems <- stringr::str_detect(string = tolower(token),
                  pattern = ustems$stem) %>% sum()

follows_relevant_prefix <- str_detect(token, pattern = str_c("^(ne)?([pd]o|[zn]a|pro)")) %>% sum()

 compounds <- stringr::str_detect(string = tolower(token),
                                 pattern = c("^samou.+", "^rychlo.{3,}", "^zpola.{3,}",
                                             str_c("^p", stri_unescape_unicode("\\u0159"), stri_unescape_unicode("\\u00ed"),"mou.{3,}"),
                                             "^celou.{3,}", "^polou.+", "^mravou.+", "^starou.{3,}",
                                             "^novou.{3,}", str_c("^st", stri_unescape_unicode("\\u0159"), "edou[^",
                                                                  stri_unescape_unicode("\\u0161"),"].{3,}"),
                                             "^severou.{3,}", "^jihou.{3,}",
                                             str_c("^z",stri_unescape_unicode("\\u00e1"), "padou.{3,}"),
                                             str_c("^v", stri_unescape_unicode("\\u00fd"),"chodou.{3,}"),
                                             "^dlouhou.{3,}",
                                             str_c("^kr",stri_unescape_unicode("\\u00e1"),"tkou.{3,}"),
                                             "^rovnou.{3,}", "^kosou.{3,}",
                                             str_c("^k", stri_unescape_unicode("\\u0159"), "ivou.{3,}"),
                                             str_c("^", stri_unescape_unicode("\\u0161"),"ikmou.{3,}"))) %>% sum()

 dediphthong <- ifelse(is_in_ustems > 0 & follows_relevant_prefix > 0 | compounds > 0, 1, 0)

 druhasuma <- sum(a,o,e,i,oau, u, y, dediphthong, ei, pbtdkghszflr)
ifelse(druhasuma == 0 & !(token %in% c(".", "\"", ":", ";", ",", "?", "!", "-","_", ")", "(", " ", "")),
                                      druhasuma <- 1 , druhasuma)
return(druhasuma)
}
