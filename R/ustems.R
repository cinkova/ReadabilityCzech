#' @name ustems
#' @title Czech word stems starting with "u" 
#' @description This lexicon was extracted from the Czech National Corpus (Araneum Bohemicum Maximum, Capek complete, and SYN Version 11), stemmed, and overtly manually cleaned. The searches targeted lemmas starting with "u" and were complemented by searches for lemmas where "u" was preceded by potential prefixes e.g.("na, za, pro, po, do"). If your Czech text has been stripped of diacritics, the lexicon-based de-diphtongization will be less sensitive. Not completely eliminated though, since the corpus returned a non-trivial amount of diacritics-less matches, and these were not deliberately removed.
#'
#' @format 
#' A data frame 
#' \describe{
#' \item{stem}{a stemmed word form starting with "u"}
#' \item{stem_unicode}{mostly NA; Unicode characters escaped. Do not use. }
#' }
#' 
#' @source #' A data frame that was obtained by parsing plain text with UDPipe. The UDPipe parser outputs a file in the CONLL-U format. Use J. Wijffels' udpipe package to parse your plain text and to convert the resulting CONLL-U format to a data frame. This data frame contains the parse of two Czech sentences and demonstrates how so-called multi-word tokens (several words contracted into one token) are handled. In most use cases, you will not care. To find out exactly which Czech words are considered multiword tokens, refer to the Universal Dependencies specification for Czech.
#'
#' @seealso Benko, V. (2014): Aranea: Yet Another Family of (Comparable) Web Corpora. In Sojka, P. – Horák, A. – Kopeček, I. – Pala, K. (eds), TSD 2014, LNAI 8655, 257–264. Springer International Publishing.
"ustems"


