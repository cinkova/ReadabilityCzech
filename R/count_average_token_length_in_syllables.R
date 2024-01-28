#' Computes mean number of syllables per token
#' 
#' Takes a conll-u data frame, removes punctuation rows with reconstructed full forms to actually spotted contracted forms, counts the remaining tokens and syllables in each token, and divides the total of syllables by the total of tokens. 
#' 
#' @param conlludf a conll-u object converted to data frame with udpipe::udpipe_read_conllu()
#' 
#' @returns a numeric value
#' 
#' @export
#'
#' @seealso [function udpipe_read_conllu in Wijffels J (2023). _udpipe: Tokenization, Parts of Speech Tagging, Lemmatization and Dependency Parsing with the 'UDPipe' 'NLP' Toolkit_. R package version 0.8.11,](https://rdocumentation.org/packages/udpipe/versions/0.8.11/topics/udpipe_read_conllu)
#'
#' @seealso create_syllablecount_per_token_df 
#' 
#' @seealso count_words_in_conllu
#' 
#' @seealso filter_out_multiwords
#' @examples
#' \dontrun{
#' The example document contains 5 non-punctuation tokens: 
#' 
#' Abys (2 syllables), to (1 syllable), etc., 10 syllables in total.
#'  
#' The mean syllable count per token is 10/5 = 2.  
#' 
#' create_syllablecount_per_token_df(two_multitokens)
#' 
#' count_average_token_length_in_syllables(two_multitokens)
#' }
count_average_token_length_in_syllables <-
function(conlludf) {
  total_syllables_in_document <- conlludf %>% 
    create_syllablecount_per_token_df() %>%
    pull(syllables) %>% 
    sum()
  total_tokens_in_document <- conlludf %>% 
    count_words_in_conllu()
  average_syllables_in_token <- total_syllables_in_document/total_tokens_in_document
  return(average_syllables_in_token)
}
