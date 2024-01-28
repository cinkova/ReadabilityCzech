#' Counts sentences in a conll-u file converted to data frame.
#'
#'Takes all unique combinations of document ID, paragraph ID, and sentence ID and counts them. It does not rely on the sentence IDs incrementing continuously. Hence no need to re-index the sentence ids when you remove some sentences before counting. It considers one data frame one document and gives no warning when the inputted data frame contains more than one document ID.   
#'
#' @param conlludf a conll-u object converted to data frame with udpipe::udpipe_read_conllu()
#' 
#' @returns a numeric value
#' 
#' @export
#' 
#' @examples 
#' \dontrun{
#' count_sentences_in_conllu(text_Vese)
#' 
#' Counts sentences in a document with 19 sentences in two paragraphs. 
#' }
#' 
#' @seealso [udpipe_read_conllu in Wijffels J (2023). _udpipe: Tokenization, Parts of Speech Tagging, Lemmatization and Dependency Parsing with the 'UDPipe' 'NLP' Toolkit_. R package version 0.8.11,](https://rdocumentation.org/packages/udpipe/versions/0.8.11/topics/udpipe_read_conllu)
#' 
count_sentences_in_conllu <-
function(conlludf){
sentence_count <- conlludf %>% 
  dplyr::select(doc_id, paragraph_id, sentence_id) %>%
dplyr::distinct() %>% 
  dplyr::count() %>% 
  dplyr::pull(n)
return(sentence_count)
}
