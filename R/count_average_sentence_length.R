#' Computes mean number of tokens per sentence
#' 
#' Takes a conll-u data frame, removes punctuation rows with reconstructed full forms to actually spotted contracted forms
#' 
#' @param conlludf a conll-u object converted to data frame with udpipe::udpipe_read_conllu()
#' 
#' @returns a numeric value
#' 
#' @export
#' 
#' @seealso [function udpipe_read_conllu in Wijffels J (2023). _udpipe: Tokenization, Parts of Speech Tagging, Lemmatization and Dependency Parsing with the 'UDPipe' 'NLP' Toolkit_. R package version 0.8.11,](https://rdocumentation.org/packages/udpipe/versions/0.8.11/topics/udpipe_read_conllu)
#'
#' @seealso count_sentences_in_conllu 
#' 
#' @seealso count_words_in_conllu
#' 
#' @seealso filter_out_multiwords
#' 
count_average_sentence_length <-
function(conlludf) {
  tokens <- conlludf %>% 
    filter_out_multiwords() %>%
    filter(!upos %in% c("PUNCT") ) %>% nrow()
  sentences <- conlludf %>% count_sentences_in_conllu()
  average_sentence_length <- tokens/sentences
  return(average_sentence_length)
}


