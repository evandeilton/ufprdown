#' ufprdown: Pacote para criar dissertações e teses na UFPR usando R Markdown
#'
#' O pacote ufprdown fornece um template R Markdown para produzir dissertações
#' e teses na Universidade Federal do Paraná (UFPR), seguindo as diretrizes
#' de formatação da classe LaTeX ppginf.cls do PPGInf/UFPR. O pacote utiliza
#' o bookdown como motor de compilação, permitindo pesquisa reprodutível com
#' código R embutido para gráficos e análises.
#'
#' @section thesis_pdf:
#' Gera a tese em formato PDF seguindo o template UFPR
#' @section thesis_gitbook:
#' Gera a tese como página web interativa
#' @section thesis_word:
#' Gera a tese em formato Microsoft Word
#' @section thesis_epub:
#' Gera a tese em formato ebook (epub)
#'
#' @section Uso:
#' Após instalar o pacote, o template aparece em:
#' \emph{File > New Project > New Directory > Tese UFPR}
#'
#' Ou compile diretamente via console R:
#' \preformatted{
#' bookdown::render_book("index.Rmd", "ufprdown::thesis_pdf")
#' }
#'
#' @section Campos YAML:
#' Os seguintes campos estão disponíveis no cabeçalho YAML:
#' \describe{
#'   \item{author}{Nome completo do autor}
#'   \item{advisor}{Nome do orientador}
#'   \item{coadvisor}{Nome do coorientador (opcional)}
#'   \item{institution}{Nome da instituição por extenso}
#'   \item{inst_short}{Sigla da instituição (ex: UFPR)}
#'   \item{field}{Área de concentração}
#'   \item{local}{Cidade e estado (ex: Curitiba PR)}
#'   \item{date_year}{Ano da defesa}
#'   \item{doc_type}{Tipo de documento: Tese, Dissertação ou Qualificação}
#'   \item{level}{Nível: doutorado ou mestrado}
#'   \item{descr}{Descrição para folha de rosto}
#'   \item{doc_mode}{Versão: defesa ou final}
#'   \item{coverimage}{Caminho para imagem de fundo da capa}
#'   \item{title}{Título da tese}
#'   \item{palavras-chave}{Palavras-chave em português}
#'   \item{keywords}{Palavras-chave em inglês}
#' }
#'
#' @keywords internal
"_PACKAGE"
