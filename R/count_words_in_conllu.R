#' Counts tokens in a conll-u file converted to data frame.
#'
#'Takes all rows that correspond to actually spotted tokens (i.e., it ignores reconstructed full form components of contracted forms)  
#'
#' @param conlludf a conll-u object converted to data frame with udpipe::udpipe_read_conllu()
#' 
#' @returns a numeric value
#' 
#' @export
#' 
#' @examples 
#' count_words_in_conllu(itsgood) ## Counts tokens in a document with 3 tokens. 
#' 
#' @seealso filter_out_multiwords
#' 
#' @seealso [udpipe_read_conllu in Wijffels J (2023). _udpipe: Tokenization, Parts of Speech Tagging, Lemmatization and Dependency Parsing with the 'UDPipe' 'NLP' Toolkit_. R package version 0.8.11,](https://rdocumentation.org/packages/udpipe/versions/0.8.11/topics/udpipe_read_conllu)
#' 
count_words_in_conllu <- function(conlludf) {
  tokcount <- conlludf %>% 
    filter(!upos %in% c("PUNCT")) %>% 
    filter_out_multiwords() %>%
    nrow()
  return(tokcount)
}
 

