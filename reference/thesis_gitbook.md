# Gera a tese como página web (gitbook)

Função usada no campo `output` do cabeçalho YAML do arquivo Rmd
principal para gerar uma versão web interativa da tese.

## Usage

``` r
thesis_gitbook(...)
```

## Arguments

- ...:

  Argumentos adicionais passados para
  [`gitbook`](https://pkgs.rstudio.com/bookdown/reference/gitbook.html).

## Value

Uma página web gitbook

## Examples

``` r
if (FALSE) { # \dontrun{
# No cabeçalho YAML:
# output:
#   ufprdown::thesis_gitbook: default
} # }
```
