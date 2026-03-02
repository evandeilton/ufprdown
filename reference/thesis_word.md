# Gera a tese em formato Word

Função usada no campo `output` do cabeçalho YAML do arquivo Rmd
principal para gerar uma versão Microsoft Word da tese.

## Usage

``` r
thesis_word(...)
```

## Arguments

- ...:

  Argumentos adicionais passados para
  [`word_document2`](https://pkgs.rstudio.com/bookdown/reference/html_document2.html).

## Value

Um documento Word

## Examples

``` r
if (FALSE) { # \dontrun{
# No cabeçalho YAML:
# output:
#   ufprdown::thesis_word: default
} # }
```
