# ufprdown

Pacote R para escrever teses, dissertações e Trabalhos de Conclusão de
Curso na UFPR usando R Markdown e bookdown.

O **ufprdown** usa o [bookdown](https://bookdown.org/) e a classe LaTeX
oficial **ppginf.cls** do
[PPGInf/UFPR](https://www.prppg.ufpr.br/site/ppginf/) para gerar
documentos no formato exigido pela Universidade Federal do Paraná, com
código R embutido para análises e figuras reprodutíveis.

O arquivo **ppginf.cls** é o template oficial do PPGInf/UFPR e não deve
ser modificado (margens, capa, folha de rosto, listas, numeração). O
pacote inclui uma cópia idêntica; personalizações devem ser feitas
apenas no YAML, em `template.tex` ou em `setup/packages.tex`.

------------------------------------------------------------------------

## Funcionalidades

- **PDF** no padrão UFPR (ppginf.cls)
- **HTML** (gitbook) para leitura no navegador
- **Word** e **epub** para revisão e leitura em outros dispositivos
- Modos **defesa** e **final** (espaçamento e elementos pré-textuais
  configuráveis)
- Tipos de documento: Tese, Dissertação, Trabalho de Conclusão de Curso,
  Qualificação
- Capa com imagem de fundo personalizável
- Bibliografia com estilo configurável (CSL) e referências em português
  (apalike-ptbr)

------------------------------------------------------------------------

## Dependências e créditos

**Pacotes R (obrigatórios):** `bookdown`, `knitr`, `rmarkdown` (Declared
in DESCRIPTION).

**Origem do template:** O ufprdown segue a mesma abordagem do
[thesisdown](https://github.com/ismayc/thesisdown) (Chester Ismay): um
template R Markdown baseado em bookdown que gera um documento acadêmico
a partir de uma classe LaTeX institucional. A estrutura e várias
convenções foram inspiradas também no
[ufscdown](https://github.com/lfpdroubi/ufscdown) (Luiz Droubi),
adaptadas para a UFPR.

**Template Base (LaTeX):** - Classe **ppginf.cls**: Criada pelo
Prof. Carlos A. Maziero (<maziero@inf.ufpr.br>) — DInf/UFPR. - **Fontes
originais da classe:** Disponíveis em seu
[Wiki](http://wiki.inf.ufpr.br/maziero/doku.php?id=software:latex) e no
repositório do [GitLab
C3SL](https://gitlab.c3sl.ufpr.br/maziero/tese). - **Aprimoramentos do
ufprdown:** O pacote R *ufprdown* utiliza a base estrutural desenhada
pelo professor Maziero e **soluciona de forma automatizada (via
R/Pandoc)** diversas pendências listadas no repositório original da
classe, tais como: - Geração automatizada das listas de símbolos e
abreviações (diretamente geridas via YAML e Markdown); - Inteligência
fluida no posicionamento de Ficha Catalográfica e Folhas de Aprovação
dependendo do “modo final” x “modo defesa”; - Distribuição isolada de
conteúdo em formato multi-arquivos para a produção veloz de capítulos
via bookdown; - Diferenciação nativa entre “Tabelas” e “Quadros” na
engine do RMarkdown; - Separação automatizada da contagem entre
Apêndices e Anexos. - [bookdown](https://bookdown.org/) (Yihui Xie).

O ufprdown não é um fork direto do `thesisdown` ou `ufscdown`; é um
pacote independente criado do zero que reutiliza a ideia da abstração do
RMarkdown e a aplica à classe nativa `ppginf.cls` da UFPR solucionando o
seu ecossistema.

------------------------------------------------------------------------

## Instalação e Requisitos

**Atenção:** Devido à complexidade e à quantidade de pacotes LaTeX
(estilos, fontes como Arial e Times, algoritmos, etc.) exigidos pelo
template da UFPR, **é estritamente necessário ter uma distribuição
completa (FULL) do LaTeX instalada** em seu computador para gerar os
PDFs. Pacotes minimalistas como o *TinyTeX* nativo costumam não ser
suficientes e podem gerar o erro de “Fatal error occurred, no output PDF
file produced”.

Por favor, instale a versão completa para o seu sistema: - **Windows:**
[TeX Live Windows](https://tug.org/texlive/windows.html) ou [MiKTeX
(instalação completa)](https://miktex.org/download) - **Linux
(Ubuntu/Debian):** Abra o terminal e rode
`sudo apt-get install texlive-full` - **macOS:**
[MacTeX](https://tug.org/mactex/)

Demais pré-requisitos: - R ≥ 3.5.0 - [Pandoc](https://pandoc.org) ≥ 2.0

``` r
install.packages(c("bookdown", "knitr", "rmarkdown"))
# Local
devtools::install_local("/caminho/para/ufprdown")
# GitHub
remotes::install_github("evandeilton/ufprdown")
```

------------------------------------------------------------------------

## Como usar

**RStudio:** File → New Project → New Directory → template **“Tese
UFPR”**. Depois, Build Book (ou Ctrl+Shift+B).

**Console:** após criar o projeto (por exemplo com
`rmarkdown::draft("minha-tese", template = "thesis", package = "ufprdown", create_dir = TRUE)`),
no diretório do projeto:

``` r
library(bookdown)
library(ufprdown)
bookdown::render_book("index.Rmd", "ufprdown::thesis_pdf")
```

Para HTML (gitbook), Word ou epub, use
[`ufprdown::thesis_gitbook`](https://evandeilton.github.io/ufprdown/reference/thesis_gitbook.md),
[`ufprdown::thesis_word`](https://evandeilton.github.io/ufprdown/reference/thesis_word.md)
ou
[`ufprdown::thesis_epub`](https://evandeilton.github.io/ufprdown/reference/thesis_epub.md)
como segundo argumento de
[`render_book()`](https://pkgs.rstudio.com/bookdown/reference/render_book.html).

------------------------------------------------------------------------

## Estrutura do projeto

Ao criar um projeto com o template:

    index.Rmd                 # Principal (YAML + introdução)
    00-abstract.Rmd          # Resumo (PT)
    00-foreignabstract.Rmd   # Abstract (EN)
    00--prelim.Rmd           # Pré-textuais (HTML)
    01-chap1.Rmd ... 04-chap4.Rmd
    96-conclusion.Rmd
    97-references.Rmd
    98-appendix.Rmd
    99-anexo.Rmd
    _bookdown.yml             # Ordem dos arquivos e rótulos em PT
    template.tex              # Template LaTeX (Pandoc → ppginf)
    ppginf.cls                # Classe UFPR (não modificar)
    setup/packages.tex        # Pacotes LaTeX adicionais
    setup/fundo-capa.png      # Imagem da capa
    bib/thesis.bib, references.bib, pkgs.bib
    csl/apa.csl
    lista_siglas.tex, lista_simbolos.tex
    apalike-ptbr.bst
    Ficha_Catalografica.pdf, aprovacao.pdf

------------------------------------------------------------------------

## Campos YAML principais

No cabeçalho do `index.Rmd`:

| Campo                                                      | Descrição                                                                                                                                              |
|------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------|
| `author`, `advisor`, `coadvisor`                           | Autoria                                                                                                                                                |
| `institution`, `inst_short`, `field`, `local`, `date_year` | Instituição e ano                                                                                                                                      |
| `doc_type`, `level`, `degree`, `course`                    | Tipo (Tese/Dissertação/Trabalho de Conclusão de Curso) e programa                                                                                      |
| `final_mode`                                               | Versão defesa (`false`) vs. versão final pós-defesa (`true`)                                                                                           |
| `title`, `abstract`, `foreignabstract`                     | Título e resumos                                                                                                                                       |
| `palavras-chave`, `keywords`                               | Palavras-chave PT/EN                                                                                                                                   |
| `font-family`                                              | Tipo de fonte para a redação do trabalho (`'Times New Roman'` ou `'Arial'`)                                                                            |
| `coverimage`, `descr`                                      | Capa e descrição na folha de rosto                                                                                                                     |
| `element_names_up`                                         | Define o rótulo de elementos textuais principais (Figura, Tabela, Apêndice, Anexo, Listas e Sumário) em caixa alta (`true` ou `false`). Padrão: `true` |
| `fig_caption_position`                                     | Define a posição do título das imagens, quadros e tabelas (`top` ou `bottom`)                                                                          |
| `thanks`, `dedication`                                     | Agradecimentos e dedicatória (só em modo final)                                                                                                        |
| `bibliography`, `csl`                                      | Arquivos .bib e estilo de citação                                                                                                                      |

Lista completa e exemplos estão na vignette:
[`vignette("ufprdown", package = "ufprdown")`](https://evandeilton.github.io/ufprdown/articles/ufprdown.md).

------------------------------------------------------------------------

## Versão defesa vs. final

- **defesa** (`final_mode: false`): espaçamento 1,5; sem ficha
  catalográfica, folha de aprovação, dedicatória ou agradecimentos.
  Documento preparado para a primeira entrega pra banca.
- **final** (`final_mode: true`): espaçamento simples; inclui todos os
  elementos pré-textuais e de assinatura necessários pós-banca.

Nos campos `thanks` e `dedication`, não use `|` no início de cada linha
(o Pandoc gera lista e ocorre erro “Lonely

” no LaTeX). Use apenas quebra de linha após o `|`:

``` yaml
thanks: |
  Agradeço a Deus...
  Ao meu orientador...
```

------------------------------------------------------------------------

## Licença

MIT © 2026 José Evandeilton Lopes
