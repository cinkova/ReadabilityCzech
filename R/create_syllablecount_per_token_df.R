#' Gives syllable count to each token
#' 
#' Takes the conllu data frame of a Czech text and counts syllables for each token
#' 
#' @param conlludf a conll-u object converted to data frame with udpipe::udpipe_read_conllu()
#' 
#' @returns a data frame 
#' 
#' @export
#'
#' @seealso Bendová, K., & Cinková, S. (2021). Adaptation of Classic Readability Metrics to Czech. In K. Ekštein, F. Pártl, & M. Konopík (Eds.), Lecture Notes in Artificial Intelligence, 24th international Conference on Text, Speech and Dialogue (Vol. 12848, pp. 159–171). Springer.
#' 
#' @seealso Kincaid, J. P., Fishburne, R. P., Rogers, R. L., Chissom, B. S., & BRANCH, N. T. T. C. M. T. R. (1975). Derivation of New Readability Formulas (Automated Readability Index, Fog Count and Flesch Reading Ease Formula) for Navy Enlisted Personnel. Defense Technical Information Center. https://books.google.cz/books?id=7Z7ENwAACAAJ
#' 
#' @seealso [function udpipe_read_conllu in Wijffels J (2023). _udpipe: Tokenization, Parts of Speech Tagging, Lemmatization and Dependency Parsing with the 'UDPipe' 'NLP' Toolkit_. R package version 0.8.11,](https://rdocumentation.org/packages/udpipe/versions/0.8.11/topics/udpipe_read_conllu)
#'
#' @seealso create_syllablecount_per_token_df 
#' 
#' @seealso count_words_in_conllu
#' 
#' @seealso filter_out_multiwords
#'   
create_syllablecount_per_token_df <-
function(conlludf) {
    syllables_df <- conlludf %>% select(doc_id, sentence_id, token_id, token, upos) %>% 
    filter(!upos %in% c("PUNCT", "X", "SYM") ) %>% 
    filter_out_multiwords() %>% rowwise() %>% 
      mutate(syllables  = count_czech_syllables(token) ) %>%
      ungroup()
    return(syllables_df)
}
