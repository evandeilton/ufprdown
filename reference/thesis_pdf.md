# Gera a tese em formato PDF

Função usada no campo `output` do cabeçalho YAML do arquivo Rmd
principal para gerar o PDF da tese seguindo o template LaTeX da UFPR
(classe ppginf.cls).

## Usage

``` r
thesis_pdf(toc = TRUE, toc_depth = 3, highlight = "default", ...)
```

## Arguments

- toc:

  Lógico. Se `TRUE`, gera o sumário (padrão: `TRUE`).

- toc_depth:

  Inteiro positivo indicando a profundidade do sumário (padrão: 3).

- highlight:

  Estilo de destaque de sintaxe. Opções: `"default"`, `"tango"`,
  `"pygments"`, `"kate"`, `"monochrome"`, `"espresso"`, `"zenburn"` e
  `"haddock"`. Use `NULL` para desativar.

- ...:

  Argumentos adicionais passados para
  [`pdf_book`](https://pkgs.rstudio.com/bookdown/reference/pdf_book.html).

## Value

Um documento `pdf_document` modificado baseado no template LaTeX da
UFPR.

## Examples

``` r
if (FALSE) { # \dontrun{
# No cabeçalho YAML do index.Rmd:
# output:
#   ufprdown::thesis_pdf:
#     latex_engine: pdflatex

# Ou compile via console R:
bookdown::render_book("index.Rmd", "ufprdown::thesis_pdf")
} # }
```
