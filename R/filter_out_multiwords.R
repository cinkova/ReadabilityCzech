#' Removes reconstructed forms from multiword tokens in conll-u. 
#' 
#' The conll-u data frame contains represents each spotted token with one row. Token ID of contracted forms (e.g. "it's") contains "-" separating the id of its first and last component (e.g. 7-8). These components (here "it" and "is") occur afterwards with regular token IDs (here 7 and 8). When counting tokens, you usually do not want these components but only the actually spotted contraction.   
#' 
#' @param conlludf a conll-u object converted to data frame with udpipe::udpipe_read_conllu()
#' 
#' @returns a data frame (conll-u data frame)
#' 
#' @export
#' 
#' @examples
#' \dontrun{
#' #' print(itsgood)
#' filter_out_multiwords(itsgood)
#' } 
#' 
#' @seealso [function udpipe_read_conllu in Wijffels J (2023). _udpipe: Tokenization, Parts of Speech Tagging, Lemmatization and Dependency Parsing with the 'UDPipe' 'NLP' Toolkit_. R package version 0.8.11,](https://rdocumentation.org/packages/udpipe/versions/0.8.11/topics/udpipe_read_conllu)
#' 
filter_out_multiwords <- function(conlludf) {
  toremove <- conlludf %>% 
    select(doc_id, sentence_id, token_id,  token) %>%
    mutate(rowid = row_number()) %>% 
    rowwise() %>% 
    filter(str_detect(token_id, "-")) %>% 
    mutate(start = str_extract(token_id, "^\\d+")) %>% 
    mutate(across(start, as.numeric)) %>%
    mutate(end = str_extract(token_id, "\\d+$")) %>%
    mutate(across(end, as.numeric)) %>% 
    mutate(indices = list(start:end)) %>% 
    unnest(indices) %>%
    mutate(across(indices, as.character)) %>% 
   select(doc_id, sentence_id, indices) %>% 
    ungroup()
  tokeep <- anti_join(conlludf, toremove, by = c("doc_id", "sentence_id", "token_id" = "indices"))
  return(tokeep)
}


