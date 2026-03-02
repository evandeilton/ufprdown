#' Gera a tese em formato PDF
#'
#' Função usada no campo \code{output} do cabeçalho YAML do arquivo Rmd
#' principal para gerar o PDF da tese seguindo o template LaTeX da UFPR
#' (classe ppginf.cls).
#'
#' @export
#'
#' @param toc Lógico. Se \code{TRUE}, gera o sumário (padrão: \code{TRUE}).
#' @param toc_depth Inteiro positivo indicando a profundidade do sumário
#'   (padrão: 3).
#' @param highlight Estilo de destaque de sintaxe. Opções: \code{"default"},
#'   \code{"tango"}, \code{"pygments"}, \code{"kate"}, \code{"monochrome"},
#'   \code{"espresso"}, \code{"zenburn"} e \code{"haddock"}. Use \code{NULL}
#'   para desativar.
#' @param ... Argumentos adicionais passados para
#'   \code{\link[bookdown]{pdf_book}}.
#'
#' @return Um documento \code{pdf_document} modificado baseado no template
#'   LaTeX da UFPR.
#'
#' @examples
#' \dontrun{
#' # No cabeçalho YAML do index.Rmd:
#' # output:
#' #   ufprdown::thesis_pdf:
#' #     latex_engine: pdflatex
#'
#' # Ou compile via console R:
#' bookdown::render_book("index.Rmd", "ufprdown::thesis_pdf")
#' }
thesis_pdf <- function(toc = TRUE, toc_depth = 3, highlight = "default", ...) {
  base <- bookdown::pdf_book(
    template = "template.tex",
    toc = toc,
    toc_depth = toc_depth,
    highlight = highlight,
    keep_tex = TRUE,
    pandoc_args = "--top-level-division=chapter",
    ...
  )

  # Opções padrão para chunks knitr
  base$knitr$opts_chunk$comment <- NA

  old_opt <- getOption("bookdown.post.latex")
  options(bookdown.post.latex = fix_envs)
  on.exit(options(bookdown.post.latex = old_opt))

  base
}

#' Gera a tese como página web (gitbook)
#'
#' Função usada no campo \code{output} do cabeçalho YAML do arquivo Rmd
#' principal para gerar uma versão web interativa da tese.
#'
#' @param ... Argumentos adicionais passados para
#'   \code{\link[bookdown]{gitbook}}.
#'
#' @export
#' @return Uma página web gitbook
#'
#' @examples
#' \dontrun{
#' # No cabeçalho YAML:
#' # output:
#' #   ufprdown::thesis_gitbook: default
#' }
thesis_gitbook <- function(...) {
  base <- bookdown::gitbook(
    split_by = "chapter+number",
    config = list(toc = list(
      collapse = "section",
      before = '<li><a href="./">Tese UFPR</a></li>',
      after = '<li><a href="https://github.com/rstudio/bookdown" target="blank">Publicado com bookdown</a></li>',
      ...
    ))
  )

  base$knitr$opts_chunk$comment <- NA
  base$knitr$opts_chunk$fig.align <- "center"

  base
}

#' Gera a tese em formato Word
#'
#' Função usada no campo \code{output} do cabeçalho YAML do arquivo Rmd
#' principal para gerar uma versão Microsoft Word da tese.
#'
#' @param ... Argumentos adicionais passados para
#'   \code{\link[bookdown]{word_document2}}.
#'
#' @export
#' @return Um documento Word
#'
#' @examples
#' \dontrun{
#' # No cabeçalho YAML:
#' # output:
#' #   ufprdown::thesis_word: default
#' }
thesis_word <- function(...) {
  base <- bookdown::word_document2(...)

  base$knitr$opts_chunk$comment <- NA
  base$knitr$opts_chunk$fig.align <- "center"

  base
}

#' Gera a tese em formato epub (ebook)
#'
#' Função usada no campo \code{output} do cabeçalho YAML do arquivo Rmd
#' principal para gerar uma versão ebook (epub) da tese.
#'
#' @param ... Argumentos adicionais passados para
#'   \code{\link[bookdown]{epub_book}}.
#'
#' @export
#' @return Um ebook em formato epub
#'
#' @examples
#' \dontrun{
#' # No cabeçalho YAML:
#' # output:
#' #   ufprdown::thesis_epub: default
#' }
thesis_epub <- function(...) {
  base <- bookdown::epub_book(...)

  base$knitr$opts_chunk$comment <- NA
  base$knitr$opts_chunk$fig.align <- "center"

  base
}

#' Corrige ambientes LaTeX
#'
#' Função interna que remove linhas em branco extras ao redor de ambientes
#' LaTeX gerados pelo pandoc, evitando espaçamento indesejado no PDF.
#'
#' @param x Vetor de caracteres com as linhas do arquivo LaTeX.
#' @return Vetor de caracteres modificado.
#' @keywords internal
fix_envs <- function(x) {
  beg_reg <- "^\\s*\\\\begin\\{.*\\}"
  end_reg <- "^\\s*\\\\end\\{.*\\}"
  i3 <- if (length(i1 <- grep(beg_reg, x))) (i1 - 1)[grepl("^\\s*$", x[i1 - 1])]

  i3 <- c(
    i3,
    if (length(i2 <- grep(end_reg, x))) (i2 + 1)[grepl("^\\s*$", x[i2 + 1])]
  )
  if (length(i3)) x <- x[-i3]
  x
}
