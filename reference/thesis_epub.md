# Gera a tese em formato epub (ebook)

Função usada no campo `output` do cabeçalho YAML do arquivo Rmd
principal para gerar uma versão ebook (epub) da tese.

## Usage

``` r
thesis_epub(...)
```

## Arguments

- ...:

  Argumentos adicionais passados para
  [`epub_book`](https://pkgs.rstudio.com/bookdown/reference/epub_book.html).

## Value

Um ebook em formato epub

## Examples

``` r
if (FALSE) { # \dontrun{
# No cabeçalho YAML:
# output:
#   ufprdown::thesis_epub: default
} # }
```
