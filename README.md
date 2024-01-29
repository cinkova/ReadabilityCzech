
<!-- README.md is generated from README.Rmd. Please edit that file -->

# ReadabilityCzech

<!-- badges: start -->

[![Codecov test
coverage](https://codecov.io/gh/cinkova/ReadabilityCzech/branch/master/graph/badge.svg)](https://app.codecov.io/gh/cinkova/ReadabilityCzech?branch=master)
[![CRAN
status](https://www.r-pkg.org/badges/version/ReadabilityCzech)](https://CRAN.R-project.org/package=ReadabilityCzech)
[![R-CMD-check](https://github.com/cinkova/ReadabilityCzech/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/cinkova/ReadabilityCzech/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

ReadabilityCzech computes readability of texts written in Czech with
language-specific adaptations of the classic readability formulas
[*Flesch Reading Ease* and *Flesch-Kincaid Grade
Level*](https://en.wikipedia.org/wiki/Flesch%E2%80%93Kincaid_readability_tests).

Both readability formulas use counts of syllables, word counts per
sentence, and sentence counts. The syllable counts per word are computed
by a dedicated script in this package. The word and sentence counts are
obtained from an automatic text analysis implemented by the [`udpipe`
package by J.
Wijffels](https://cran.r-project.org/web/packages/udpipe/vignettes/udpipe-universe.html).

## Installation

You can install the development version of ReadabilityCzech like so:

``` r
devtools::install_github("cinkova/ReadabilityCzech")
#> Downloading GitHub repo cinkova/ReadabilityCzech@HEAD
#> rlang   (1.1.1  -> 1.1.3) [CRAN]
#> glue    (1.6.2  -> 1.7.0) [CRAN]
#> cli     (3.6.1  -> 3.6.2) [CRAN]
#> utf8    (1.2.3  -> 1.2.4) [CRAN]
#> fansi   (1.0.4  -> 1.0.6) [CRAN]
#> stringi (1.7.12 -> 1.8.3) [CRAN]
#> purrr   (1.0.1  -> 1.0.2) [CRAN]
#> dplyr   (1.1.2  -> 1.1.4) [CRAN]
#> tidyr   (1.3.0  -> 1.3.1) [CRAN]
#> readr   (2.1.4  -> 2.1.5) [CRAN]
#> Installing 10 packages: rlang, glue, cli, utf8, fansi, stringi, purrr, dplyr, tidyr, readr
#> Installing packages into 'C:/Users/cinkova/AppData/Local/Temp/Rtmp6HHbnt/temp_libpatha6416021f91'
#> (as 'lib' is unspecified)
#> package 'rlang' successfully unpacked and MD5 sums checked
#> package 'glue' successfully unpacked and MD5 sums checked
#> package 'cli' successfully unpacked and MD5 sums checked
#> package 'utf8' successfully unpacked and MD5 sums checked
#> package 'fansi' successfully unpacked and MD5 sums checked
#> package 'stringi' successfully unpacked and MD5 sums checked
#> package 'purrr' successfully unpacked and MD5 sums checked
#> package 'dplyr' successfully unpacked and MD5 sums checked
#> package 'tidyr' successfully unpacked and MD5 sums checked
#> package 'readr' successfully unpacked and MD5 sums checked
#> 
#> The downloaded binary packages are in
#>  C:\Users\cinkova\AppData\Local\Temp\Rtmp0wwzAV\downloaded_packages
#> ── R CMD build ─────────────────────────────────────────────────────────────────
#>          checking for file 'C:\Users\cinkova\AppData\Local\Temp\Rtmp0wwzAV\remotes858542c4ffa\cinkova-ReadabilityCzech-fbf445e/DESCRIPTION' ...  ✔  checking for file 'C:\Users\cinkova\AppData\Local\Temp\Rtmp0wwzAV\remotes858542c4ffa\cinkova-ReadabilityCzech-fbf445e/DESCRIPTION'
#>       ─  preparing 'ReadabilityCzech':
#>    checking DESCRIPTION meta-information ...     checking DESCRIPTION meta-information ...   ✔  checking DESCRIPTION meta-information
#>       ─  checking for LF line-endings in source and make files and shell scripts
#>       ─  checking for empty or unneeded directories
#>       ─  building 'ReadabilityCzech_0.1.1.tar.gz'
#>      
#> 
#> Installing package into 'C:/Users/cinkova/AppData/Local/Temp/Rtmp6HHbnt/temp_libpatha6416021f91'
#> (as 'lib' is unspecified)
```

## Example

### Preprocessing

You want to gauge the readability of a Czech text. This is how you
prepare it:

- Make sure that it is UTF-8 encoded and in the plain text format.
- Use an NLP tool - a syntactic parser. It will
  - tokenize the text (ie. recognize word and sentence boundaries)
  - tell you the part of speech and lemma of each word
  - display syntactic relations between words (not needed in this use
    case).

There are many NLP tools, but you need one that works with [Universal
Dependencies](universaldependencies.org). For Czech we recommend
[UDPipe](https://lindat.mff.cuni.cz/services/udpipe/info.php) with the
language model `czech-pdt-udXXXX`.

You can use UDPipe through:

- [Web GUI](https://lindat.mff.cuni.cz/services/udpipe/)

- [REST
  API](https://lindat.mff.cuni.cz/services/udpipe/api-reference.php)

- R package [`udpipe`](https://CRAN.R-project.org/package=udpipe)

Note that the `udpipe` R package uses
[UDPipe1](https://ufal.mff.cuni.cz/udpipe/1), whereas the GUI and API
point to the current version of
[UDPipe2](https://ufal.mff.cuni.cz/udpipe/2). However, for the
readability use case this hardly makes any difference.

The output from the parser will be in the so-called
[CONLL-U](https://universaldependencies.org/format.html) format, which
looks like this:

    # generator = UDPipe 2, https://lindat.mff.cuni.cz/services/udpipe
    # udpipe_model = english-ewt-ud-2.12-230717
    # udpipe_model_licence = CC BY-NC-SA
    # newdoc
    # newpar
    # sent_id = 1
    # text = It is ok.
    1   It  it  PRON    PRP Case=Nom|Gender=Neut|Number=Sing|Person=3|PronType=Prs  3   nsubj   _   TokenRange=0:2
    2   is  be  AUX VBZ Mood=Ind|Number=Sing|Person=3|Tense=Pres|VerbForm=Fin   3   cop _   TokenRange=3:5
    3   ok  ok  ADJ JJ  Degree=Pos  0   root    _   SpaceAfter=No|TokenRange=6:8
    4   .   .   PUNCT   .   _   3   punct   _   TokenRange=8:9

``` r
library(ReadabilityCzech)
library(udpipe)
library(tidyverse)
library(magrittr)
```

We are going to compute the readability of a passage from a freely
available e-book in Czech:

``` r
plaintext <- read_lines("https://www.gutenberg.org/cache/epub/29648/pg29648.txt") %>% 
  stringr::str_flatten(collapse = " ") %>% str_sub(start = 3008, end = 7508)
```

Here are the first 505 characters of `plaintext`.

``` r
plaintext %>% str_sub(start = 1, end = 505)
#> [1] "Z dálky se ozýval temný hukot obrovských ledových ker, které na sebe s rachotem narážely, spojovaly se a zase praskaly, až se země zachvívala.  Přes nepohodu se začaly k sedmé hodině dveře domů otvírat a do vánice vycházeli rodiče se svými dětmi. Vítr se do nich opřel, sotva překročili práh domu, ostrými jehlami se zabodl do jejich tváří a pronikal až do kostí. Chodci se zachvěli zimou, vtáhli se do svých těžkých zimníků, maminky přitáhly dětem šály a čapky vtlačily až na oči, ale nic nebylo platno. "
```

### Three ways to obtain a `.conllu` file from your plain text

This is one of the possible ways to obtain the conll-u file using the
REST-API. If you choose this way, you will have to mount specialized
libraries for API handling.

``` r
library(RCurl)
#> 
#> Attaching package: 'RCurl'
#> The following object is masked from 'package:tidyr':
#> 
#>     complete
library(jsonlite)
#> 
#> Attaching package: 'jsonlite'
#> The following object is masked from 'package:purrr':
#> 
#>     flatten

proresult <- RCurl::postForm(uri = "https://lindat.mff.cuni.cz/services/udpipe/api/process", 
                             .params = c(data = plaintext, tokenizer = TRUE, 
                                         tagger = TRUE, parser = TRUE, 
                                         model = "czech-pdt-ud-2.12-230717") ) %>%
  fromJSON() 
result <- proresult$result
write_lines(result, file = "data-raw/result_plaintext.conllu")
```

Another way would be with the `udpipe` library. Here is a cookbook. For
more details, refer to the `udpipe` package documentation.

First download the appropriate language model (naming just the language
picks the largest if several are available). To see the list of models,
you have to consult the [UDPipe1
documentation](https://ufal.mff.cuni.cz/udpipe/1).

``` r
czech_model <- udpipe::udpipe_download_model(language = "czech", model_dir = "data-raw")
```

Then load (i.e. activate) the model.

``` r
czech <- udpipe::udpipe_load_model(czech_model$file_model)
```

Eventually, run the parser locally on your computer, using the model you
have downloaded and then loaded.

``` r
plaintext_udpipeR <- udpipe::udpipe_annotate(object = czech, x = plaintext, 
                                        tokenizer = "tokenizer", 
                                        tagger = "default", 
                                        parser = "default")
```

You could save some time with setting `parser` to `"none"`, when you
process large data.

``` r
result_udpipeR <- plaintext_udpipeR$conllu
write_lines(result_udpipeR, "data-raw/result_plaintext_udpipeR.conllu")
```

Since each of these methods uses a different version of the language
model and tool, the files are not identical (but both do a good job).

If you do not mind fiddling with the UDPipe web GUI, upload a plain text
file or copy-paste a plain text in the GUI, select the Czech model, hit
the Process Input button and then the Save Output File button.

Whichever way you have used, at this point you should have a file with
the suffix `.conllu`.

### Converting the `.conllu` file to the conll-u data frame

For this this task, you need the `udpipe` package.

``` r
plaintext_df <- udpipe_read_conllu(file = "data-raw/result_plaintext.conllu")
glimpse(plaintext_df)
#> Rows: 985
#> Columns: 14
#> $ doc_id        <chr> "# newdoc", "# newdoc", "# newdoc", "# newdoc", "# newdo…
#> $ paragraph_id  <int> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,…
#> $ sentence_id   <chr> "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "…
#> $ sentence      <chr> "Z dálky se ozýval temný hukot obrovských ledových ker, …
#> $ token_id      <chr> "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11",…
#> $ token         <chr> "Z", "dálky", "se", "ozýval", "temný", "hukot", "obrovsk…
#> $ lemma         <chr> "z", "dálka", "se", "ozývat", "temný", "hukot", "obrovsk…
#> $ upos          <chr> "ADP", "NOUN", "PRON", "VERB", "ADJ", "NOUN", "ADJ", "AD…
#> $ xpos          <chr> "RR--2----------", "NNFS2-----A----", "P7-X4----------",…
#> $ feats         <chr> "AdpType=Prep|Case=Gen", "Case=Gen|Gender=Fem|Number=Sin…
#> $ head_token_id <chr> "2", "4", "4", "0", "6", "4", "9", "9", "6", "16", "16",…
#> $ dep_rel       <chr> "case", "obl", "expl:pv", "root", "amod", "nsubj", "amod…
#> $ deps          <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
#> $ misc          <chr> NA, NA, NA, NA, NA, NA, NA, NA, "SpaceAfter=No", NA, NA,…
```

## Computing readability

### Flesch Reading Ease

``` r
compute_FRE(plaintext_df)
#> [1] 68.11533
```

### Flesch-Kincaid Grade Level

``` r
compute_FleschKincaidGradeLevel(plaintext_df)
#> [1] 7.015419
```

## Other text statistics

Both readability scores are based on sentence, word, and syllable
counts. If you are interested in these statistics, you can use functions
that were built to support `compute_FRE()`
and`compute_FleschKincaidGradeLevel()`.

``` r
count_sentences_in_conllu(plaintext_df)
#> [1] 69
```

``` r
count_average_sentence_length(plaintext_df)
#> [1] 11
```

``` r
count_words_in_conllu(plaintext_df)
#> [1] 759
```

``` r
count_average_token_length_in_syllables(plaintext_df)
#> [1] 1.936759
```

``` r
create_syllablecount_per_token_df(plaintext_df) %>% slice_head(n = 10)
#> # A tibble: 10 × 6
#>    doc_id   sentence_id token_id token      upos  syllables
#>    <chr>    <chr>       <chr>    <chr>      <chr>     <dbl>
#>  1 # newdoc 1           1        Z          ADP           1
#>  2 # newdoc 1           2        dálky      NOUN          2
#>  3 # newdoc 1           3        se         PRON          1
#>  4 # newdoc 1           4        ozýval     VERB          3
#>  5 # newdoc 1           5        temný      ADJ           2
#>  6 # newdoc 1           6        hukot      NOUN          2
#>  7 # newdoc 1           7        obrovských ADJ           3
#>  8 # newdoc 1           8        ledových   ADJ           3
#>  9 # newdoc 1           9        ker        NOUN          1
#> 10 # newdoc 1           11       které      DET           2
```

## Acknowledgments

Supported by the Czech Science Foundation grant 19-19191S: Linguistic
Factors of Readability in Czech Administrative and Educational Texts.
The work described herein has also been using data/tools/services
provided by the LINDAT/CLARIAH-CZ Research Infrastructure
(<https://lindat.cz>) (Project No. LM2018101) and Czech National Corpus
(Project No. LM2023044), both supported by the Ministry of Education,
Youth and Sports of the Czech Republic.

If you use this package, please cite this paper:

    @inproceedings{biblio:BeCiAdaptationClassic2021,
        address = {Cham, Switzerland},
        series = {Lecture Notes in Computer Science},
        title = {{Adaptation of Classic Readability Metrics to Czech}},
        volume = {12848},
        copyright = {All rights reserved},
        isbn = {978-3-030-83526-2},
        booktitle = {{Lecture Notes in Artificial Intelligence, 24th International Conference on Text, Speech and Dialogue}},
        publisher = {Springer},
        author = {Bendová, Klára and Cinková, Silvie},
        editor = {Ekštein, Kamil and Pártl, František and Konopík, Miroslav},
        year = {2021},
        note = {tex.organization: University of West Bohemia},
        pages = {159--171},
    }
