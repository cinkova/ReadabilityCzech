#' @name itsgood
#' @title An English sentence with contracted forms
#' @description An English text converted to conll-u data frame
#' @format 
#' A data frame from the CONLL-U format
#' \describe{
#' \item{doc_id}{document ID}
#' \item{paragraph_id}{paragraph ID}
#' \item{sentence_id}{sentence ID, increments throughout the document}
#' \item{sentence}{the text of the sentence}
#' \item{token_id}{token ID, represents word order and is only unique within a sentence}
#' \item{token}{the word form of the token}
#' \item{lemma}{basic dictionary form of the actually spotted word form}
#' \item{upos}{coarse-grained part of speech (e.g. noun, verb) in the Universal Dependencies annotation scheme}
#' \item{xpos}{morphological tag from a different annotation scheme}
#' \item{feats}{more morphological details beyond part of speech; e.g. case, tense}
#' \item{head_token_id}{ID of the token that syntactically governs this one}
#' \item{dep_rel}{syntactic relation label}
#' \item{deps}{--}
#' \item{misc}{--} 
#' }
#' 
#' @source #' A data frame that was obtained by parsing plain text with UDPipe. The UDPipe parser outputs a file in the CONLL-U format. Use J. Wijffels' udpipe package to parse your plain text and to convert the resulting CONLL-U format to a data frame. This data frame contains the parse of one English sentence and demonstrates how so-called multi-word tokens (several words contracted into one token) are handled. In most use cases, you will not care. To find out exactly which Czech words are considered multiword tokens, refer to the Universal Dependencies specification for Czech.
#' 
#' @seealso two_multitokens
#' 
#' @seealso [Universal Dependencies specification for Czech](https://universaldependencies.org/cs/)
#' 
#' @seealso Straka, M. (2018). UDPipe 2.0 Prototype at CoNLL 2018 UD Shared Task. Proceedings of the CoNLL 2018 Shared Task: Multilingual Parsing from Raw Text to Universal Dependencies, 197–207. https://doi.org/10.18653/v1/K18-2020
#' 
#' @seealso [function udpipe_read_conllu in Wijffels J (2023). _udpipe: Tokenization, Parts of Speech Tagging, Lemmatization and Dependency Parsing with the 'UDPipe' 'NLP' Toolkit_. R package version 0.8.11,](https://rdocumentation.org/packages/udpipe/versions/0.8.11/topics/udpipe_read_conllu)
"itsgood"

