# ufprdown: Recursos e uso do pacote

## Introdução

O **ufprdown** é um pacote R que fornece um template em R Markdown para
a produção de **teses**, **dissertações** e **trabalhos de conclusão de
curso (TCC)** no formato exigido pela Universidade Federal do Paraná
(UFPR). Ele utiliza o [bookdown](https://bookdown.org/) para compilar um
livro multipágina e a classe LaTeX oficial **ppginf.cls** do
[PPGInf/UFPR](https://www.prppg.ufpr.br/site/ppginf/) para garantir a
conformidade com as normas da instituição.

Este guia descreve em detalhe os recursos do pacote, a estrutura do
projeto gerado, as opções de configuração (YAML), os formatos de saída,
o fluxo de compilação e boas práticas de uso.

### Principais funcionalidades

- **PDF** no padrão UFPR (classe `ppginf.cls`)
- **HTML** interativo (gitbook) para leitura no navegador
- **Word** para revisão e anotações
- **epub** para leitura em dispositivos móveis
- **Reprodutibilidade**: código R embutido gera gráficos e tabelas
  automaticamente
- **Dois modos de documento**: versão para **defesa** (espaçamento 1,5;
  sem ficha catalográfica, aprovação, dedicatória/agradecimentos) e
  versão **final** (espaçamento simples; elementos pré-textuais
  completos)
- **Tipos de documento**: Tese (doutorado), Dissertação (mestrado), TCC
  (bacharelado) e Qualificação, com `degree` e `course` configuráveis
- **Capa** com imagem de fundo personalizável
- **Bibliografia** com estilo de citação configurável (CSL) e
  referências em português (apalike-ptbr)

------------------------------------------------------------------------

## Instalação

O ufprdown depende dos pacotes **bookdown**, **knitr** e **rmarkdown**.
Para instalar a partir do código-fonte ou do GitHub:

``` r
# Dependências
install.packages(c("bookdown", "knitr", "rmarkdown"))

# Instalação local (desenvolvimento)
install.packages("devtools")
devtools::install_local("/caminho/para/ufprdown")

# Ou a partir do GitHub
remotes::install_github("evandeilton/ufprdown")
```

**Requisitos de sistema:**

- **R** ≥ 3.5.0  
- **Pandoc** ≥ 2.0 ([pandoc.org](https://pandoc.org))  
- **LaTeX Completo (FULL)**: Devido à enorme quantidade de pacotes LaTeX
  exigidos pela classe da UFPR (como bibliotecas avançadas de
  formatação, algoritmos e as fontes Times/Arial), **é estritamente
  necessário** ter uma distribuição TeX/LaTeX *completa* instalada no
  seu PC. Distribuições minimalistas internas do R (como o o *TinyTeX*)
  podem falhar ao compilar o PDF com o erro “Fatal error occurred, no
  output PDF file produced”. Instale:
  - **Windows**: [MiKTeX (completo)](https://miktex.org/download) ou
    [TeX Live](https://tug.org/texlive/windows.html)
  - **Linux (Debian/Ubuntu)**: Vá ao terminal e rode
    `sudo apt-get install texlive-full`
  - **macOS**: [MacTeX](https://tug.org/mactex/)

------------------------------------------------------------------------

## Criando um novo projeto

### Via RStudio

1.  Instale o pacote conforme acima.  
2.  **File → New Project → New Directory**.  
3.  Selecione o template **“Tese UFPR”**.  
4.  Defina o diretório do projeto e clique em **Create Project**.  
5.  O RStudio abrirá um projeto bookdown com o skeleton completo
    (arquivos `.Rmd`, `template.tex`, `ppginf.cls`, etc.).

Para compilar o livro: use o botão **Build Book** na aba *Build* ou o
atalho **Ctrl+Shift+B**.

### Via console R

É possível criar um projeto a partir do template programaticamente
usando as funções do **rmarkdown**:

``` r
library(rmarkdown)
# Cria um diretório com o skeleton do template "thesis"
rmarkdown::draft(
  "minha-tese",
  template = "thesis",
  package = "ufprdown",
  create_dir = TRUE,
  edit = FALSE
)
setwd("minha-tese")
```

Em seguida, edite o `index.Rmd` (ou o arquivo principal gerado, se o
nome for outro) e compile com:

``` r
library(bookdown)
library(ufprdown)
bookdown::render_book("index.Rmd", "ufprdown::thesis_pdf")
```

**Nota:** O template do rmarkdown usa por padrão o arquivo
**skeleton.Rmd** como base; ao criar o projeto, esse arquivo pode ser
renomeado para **index.Rmd** (que é o arquivo principal esperado pelo
`_bookdown.yml`).

------------------------------------------------------------------------

## Estrutura do projeto

Após criar um projeto com o template, você terá uma estrutura semelhante
à seguinte:

| Caminho                                                | Descrição                                                                 |
|--------------------------------------------------------|---------------------------------------------------------------------------|
| `index.Rmd`                                            | Arquivo principal: YAML da tese + introdução                              |
| `00-abstract.Rmd`                                      | Resumo em português                                                       |
| `00-foreignabstract.Rmd`                               | Abstract em inglês                                                        |
| `00--prelim.Rmd`                                       | Elementos pré-textuais (versão HTML: dedicatória, agradecimentos, resumo) |
| `01-chap1.Rmd` … `04-chap4.Rmd`                        | Capítulos do corpo                                                        |
| `96-conclusion.Rmd`                                    | Conclusão                                                                 |
| `97-references.Rmd`                                    | Referências bibliográficas                                                |
| `98-appendix.Rmd`                                      | Apêndices                                                                 |
| `99-anexo.Rmd`                                         | Anexos                                                                    |
| `_bookdown.yml`                                        | Configuração do bookdown (ordem dos arquivos, rótulos em PT)              |
| `template.tex`                                         | Template LaTeX (Pandoc → ppginf)                                          |
| `ppginf.cls`                                           | Classe oficial PPGInf/UFPR (**não modificar**)                            |
| `setup/packages.tex`                                   | Pacotes e comandos LaTeX adicionais                                       |
| `setup/fundo-capa.png`                                 | Imagem de fundo da capa                                                   |
| `bib/thesis.bib`, `bib/references.bib`, `bib/pkgs.bib` | Arquivos BibTeX                                                           |
| `csl/apa.csl`                                          | Estilo de citação (CSL)                                                   |
| `lista_siglas.tex`, `lista_simbolos.tex`               | Listas de siglas e símbolos                                               |
| `apalike-ptbr.bst`                                     | Estilo bibliográfico (referências em PT-BR)                               |

O **ppginf.cls** é uma cópia do template oficial do PPGInf/UFPR e contém
os padrões de formatação da universidade (margens, capa, folha de rosto,
listas, numeração). Personalizações devem ser feitas apenas no YAML, no
`template.tex` ou em `setup/packages.tex`.

------------------------------------------------------------------------

## Formatos de saída

O pacote expõe quatro funções de output para uso no campo `output` do
YAML ou em
[`render_book()`](https://pkgs.rstudio.com/bookdown/reference/render_book.html).

### PDF: `thesis_pdf`

Gera o PDF da tese usando o template LaTeX da UFPR.

**Argumentos principais:**

- `toc`: incluir sumário (padrão `TRUE`)
- `toc_depth`: profundidade do sumário (padrão 3)
- `highlight`: estilo de destaque de sintaxe para código (`"default"`,
  `"tango"`, `"pygments"`, etc.; use `NULL` para desativar)
- `...`: repassados a
  [`bookdown::pdf_book`](https://pkgs.rstudio.com/bookdown/reference/pdf_book.html)
  (ex.: `latex_engine`)

**Exemplo no YAML do `index.Rmd`:**

``` yaml
output:
  ufprdown::thesis_pdf:
    toc: true
    toc_depth: 3
    latex_engine: pdflatex
```

**Exemplo via console:**

``` r
bookdown::render_book("index.Rmd", "ufprdown::thesis_pdf")
```

O PDF é escrito em `_book/render-thesis.pdf` (ou o nome definido em
`book_filename` no `_bookdown.yml`).

### Gitbook: `thesis_gitbook`

Gera uma versão web interativa (HTML) no estilo gitbook.

**Exemplo YAML:**

``` yaml
output:
  ufprdown::thesis_gitbook: default
```

**Exemplo via console:**

``` r
bookdown::render_book("index.Rmd", "ufprdown::thesis_gitbook")
```

### Word: `thesis_word`

Gera um documento Word para revisão ou impressão informal.

``` yaml
output:
  ufprdown::thesis_word: default
```

``` r
bookdown::render_book("index.Rmd", "ufprdown::thesis_word")
```

### epub: `thesis_epub`

Gera um ebook no formato epub.

``` yaml
output:
  ufprdown::thesis_epub: default
```

``` r
bookdown::render_book("index.Rmd", "ufprdown::thesis_epub")
```

Para alternar entre formatos sem editar o YAML a cada vez, use o segundo
argumento de
[`render_book()`](https://pkgs.rstudio.com/bookdown/reference/render_book.html)
conforme os exemplos acima.

------------------------------------------------------------------------

## Referência dos parâmetros editáveis (YAML)

O ufprdown foi projetado para ser altamente personalizável sem que o
usuário precise alterar o código LaTeX oficial (`ppginf.cls`). Os
parâmetros mutáveis – aqueles que você **pode e deve** alterar para
personalizar seu trabalho – estão centralizados principalmente no
cabeçalho **YAML** do arquivo principal (geralmente `index.Rmd`).

As opções abaixo descrevem em detalhes cada grupo de configuração.

### 1. Metadados de Autoria e Orientação

Estes são os campos básicos de identificação do trabalho:

| Campo       | Descrição                                                | Exemplo                          |
|-------------|----------------------------------------------------------|----------------------------------|
| `author`    | Nome completo do autor                                   | `'José Evandeilton Lopes'`       |
| `advisor`   | Orientador do trabalho                                   | `'Prof. Wagner Hugo Bonat, PhD'` |
| `coadvisor` | Coorientador (opcional, remova ou comente se não houver) | `'Prof. Nome, Dr.'`              |

### 2. Atributos da Instituição e Curso

| Campo         | Descrição                        | Exemplo                             |
|---------------|----------------------------------|-------------------------------------|
| `institution` | Nome da instituição por extenso  | `'Universidade Federal do Paraná'`  |
| `inst_short`  | Sigla da instituição             | `'UFPR'`                            |
| `field`       | Área de concentração do programa | `'Métodos Numéricos em Engenharia'` |
| `local`       | Cidade e estado da defesa        | `'Curitiba PR'`                     |
| `date_year`   | Ano da defesa ou entrega         | `'2026'`                            |
| `lang`        | Idioma principal do documento    | `'pt-BR'`                           |

### 3. Classificação Acadêmica do Documento

Estes campos definem o texto que aparecerá automaticamente na capa,
folha de rosto e aprovação:

| Campo      | Descrição                                                                                                 | Exemplo                                              |
|------------|-----------------------------------------------------------------------------------------------------------|------------------------------------------------------|
| `doc_type` | Tipo do trabalho                                                                                          | `'Tese'`, `'Dissertação'`, `'TCC'`, `'Qualificação'` |
| `level`    | Nível acadêmico                                                                                           | `'doutorado'`, `'mestrado'`, `'bacharelado'`         |
| `degree`   | Título / Grau que será obtido                                                                             | `'Doutor em Ciências'`, `'Mestre em ...'`            |
| `course`   | Nome completo do programa/curso                                                                           | `'Programa de Pós-Graduação em ...'`                 |
| `descr`    | Texto customizado para folha de rosto. Se omitido, o template o gera via `doc_type`, `degree` e `course`. |                                                      |

### 4. Controle de Versão (Defesa vs. Final)

Estes são os parâmetros mais vitais para o fluxo de revisão do
documento:

[TABLE]

**Importante (modo final):** Nos campos `thanks` e `dedication`, **não
use `|` (pipe mais espaço) no início de cada linha**. Esse formato é
interpretado pelo Pandoc como lista e gera `\item` no LaTeX, causando
erro “Lonely

“. Use apenas o pipe da string multilinha e quebras de linha normais,
por exemplo:

``` yaml
thanks: |
  Agradeço a Deus...
  Ao meu orientador...
dedication: |
  Dedico esta tese a...
```

### 5. Conteúdo Textual Específico

| Campo             | Descrição                                                             |
|-------------------|-----------------------------------------------------------------------|
| `title`           | Título completo do trabalho (pode ser multilinha usando `>`)          |
| `abstract`        | O resumo em português (por padrão, puxa do arquivo `00-abstract.Rmd`) |
| `foreignabstract` | O abstract em inglês (puxa do arquivo `00-foreignabstract.Rmd`)       |
| `palavras-chave`  | Lista de palavras-chave em Português                                  |
| `keywords`        | Lista de palavras-chave em Inglês                                     |
| `dedication`      | Texto da dedicatória (visível apenas na versão final)                 |
| `thanks`          | Texto dos agradecimentos (visível apenas na versão final)             |

### 6. Design e Bibliografia

| Campo                  | Descrição                                                                                                                                              |
|------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------|
| `font-family`          | Tipo de fonte da redação do trabalho (`'Times New Roman'` ou `'Arial'`). Padrão: `'Times New Roman'`                                                   |
| `coverimage`           | Caminho da imagem de fundo da capa (padrão: `'setup/fundo-capa.png'`)                                                                                  |
| `element_names_up`     | Define rótulos textuais principais (Figura, Tabela, Apêndice, Anexo, Sumário, Bibliografia, Listas) em caixa alta. Valores: `true` (padrão) ou `false` |
| `fig_caption_position` | Define a posição da legenda das imagens e gráficos. Valores: `'top'` ou `'bottom'`                                                                     |
| `bibliography`         | Lista de arquivos `.bib` contendo as referências (ex: `["bib/thesis.bib", "bib/references.bib"]`).                                                     |
| `csl`                  | Estilo de citação. O padrão é APA (`csl/apa.csl`), mas você pode usar outros (ex: ABNT).                                                               |
| `link-citations`       | `yes` ou `no`. Define se as citações no texto serão links clicáveis para as referências.                                                               |

------------------------------------------------------------------------

## Arquivos complementares editáveis

Além do YAML, a estrutura espera que o usuário modifique os seguintes
arquivos periféricos gerados com o skeleton:

1.  **Os Capítulos (`01-chap1.Rmd`, `02-chap2.Rmd`, etc.):** Onde você
    escreve o texto e os códigos R.
2.  **`_bookdown.yml`**: Define a ordem de compilação dos arquivos
    `.Rmd` (útil ao adicionar novos capítulos).
3.  **`setup/packages.tex`**: Local correto para adicionar pacotes LaTeX
    extras (`\usepackage{...}`).
4.  **`lista_siglas.tex` e `lista_simbolos.tex`**: Arquivos LaTeX para
    preencher siglas e símbolos manualmente.
5.  **A pasta `bib/`**: Repositório para os arquivos `.bib` (exportados
    do Mendeley, Zotero, etc.).
6.  **PDFs de Pós-Defesa (`Ficha_Catalografica.pdf` e
    `aprovacao.pdf`)**: Quando for gerar a versão final, basta
    substituir os arquivos de exemplo pelos PDFs oficiais fornecidos
    pela biblioteca da UFPR.

------------------------------------------------------------------------

## Compilação

A compilação é feita pelo **bookdown**, que concatena os arquivos
listados em `_bookdown.yml`, processa os Rmd com knitr e passa o LaTeX
gerado ao Pandoc e ao motor LaTeX.

1.  **No RStudio:** use **Build Book** (ou Ctrl+Shift+B) com o output
    padrão definido no YAML.

2.  **No console R**, a partir do diretório do projeto:

``` r
library(bookdown)
library(ufprdown)

# PDF (padrão do template)
render_book("index.Rmd", "ufprdown::thesis_pdf")

# Outros formatos
render_book("index.Rmd", "ufprdown::thesis_gitbook")
render_book("index.Rmd", "ufprdown::thesis_word")
render_book("index.Rmd", "ufprdown::thesis_epub")
```

Os artefatos são gravados em `_book/` (nome do livro definido por
`book_filename` em `_bookdown.yml`).

------------------------------------------------------------------------

## Referências cruzadas e elementos textuais

O bookdown e o template suportam rótulos em português (configurados em
`_bookdown.yml`): figuras, tabelas, quadros, equações, teoremas,
definições, etc.

### Figuras

- Defina um label no chunk com a opção `fig.cap`:

&nbsp;

    ``` r
    # código que gera o gráfico
    ```

- No texto: `A Figura \@ref(fig:nome-chunk) mostra...`

### Tabelas e quadros

- Use `kable()` (ou equivalente) com `caption` e um identificador de
  tabela/quadro. Para nota explicativa, use um parágrafo seguinte no
  texto (ex.: *Nota:* Fonte: …), pois `^[]` no caption pode causar
  problemas no LaTeX.

- Referência: `A Tabela \@ref(tab:label) ...` ou
  `O Quadro \@ref(qua:label) ...`.

### Equações

- Equação numerada: use `(\#eq:label)` após a equação e cite com
  `\@ref(eq:label)`.

### Teoremas, definições, proposições

- Use blocos de extensão do Pandoc, por exemplo:

&nbsp;

    ::: {.definition #id-def}
    Conteúdo da definição.
    :::

- Cite com `\@ref(def:id-def)`. De forma análoga: `{.theorem #id}`,
  `\@ref(thm:id)`; etc., conforme os rótulos definidos em
  `_bookdown.yml` (thm, lem, def, cor, prp, exm, rem).

### Algoritmos

- Use o ambiente LaTeX `algorithm` com `\label{alg:id}` e cite com
  `\@ref(alg:id)`.

### Citações bibliográficas

- No texto: `@autor2020` (citação narrativa) ou `[@autor2020]` (entre
  parênteses). A lista de referências é gerada a partir dos arquivos em
  `bibliography` e do estilo definido em `csl`.

------------------------------------------------------------------------

## Apêndices e anexos

- **Apêndice:** no arquivo (ex.: `98-appendix.Rmd`), antes dos capítulos
  de apêndice, insira no Rmd (apenas para LaTeX) `\appendix`. Os
  capítulos passam a ser numerados como Apêndice A, B, etc.

- **Anexo:** no arquivo (ex.: `99-anexo.Rmd`), use `\anexo` (comando
  definido em `setup/packages.tex`) e em seguida os capítulos de anexo
  (Anexo A, B, etc.).

------------------------------------------------------------------------

## Personalização

- **Capa:** troque a imagem `setup/fundo-capa.png` ou altere o campo
  YAML `coverimage`.
- **Pacotes e comandos LaTeX:** edite apenas `setup/packages.tex` (não
  altere `ppginf.cls`).
- **Template Pandoc → LaTeX:** ajustes finos no `template.tex`
  (variáveis Pandoc, inclusão de arquivos, ambientes). O `ppginf.cls`
  deve permanecer igual ao oficial.

------------------------------------------------------------------------

## Resumo rápido

| Objetivo             | Ação                                                                                                    |
|----------------------|---------------------------------------------------------------------------------------------------------|
| Criar projeto        | RStudio: New Project → Tese UFPR; ou `rmarkdown::draft(..., template = "thesis", package = "ufprdown")` |
| Gerar PDF            | `render_book("index.Rmd", "ufprdown::thesis_pdf")` ou Build Book no RStudio                             |
| Versão defesa        | `final_mode: false`                                                                                     |
| Versão final         | `final_mode: true`; preencher `thanks`/`dedication` sem `\|` no início das linhas                       |
| Dissertação/TCC      | Ajustar `doc_type`, `level`, `degree` e `course` no YAML                                                |
| Referências cruzadas | `\@ref(fig:...)`, `\@ref(tab:...)`, `\@ref(eq:...)`, `\@ref(thm:...)`, etc.                             |
| Citações             | `@chave` ou `[@chave]`; `bibliography` e `csl` no YAML                                                  |

------------------------------------------------------------------------

## Origem e Créditos

O pacote **ufprdown** usa o RMarkdown e o ecossistema `bookdown` para
entregar a abstração completa do template LaTeX do **PPGInf/UFPR**.

**Template Base (LaTeX):** - A classe **ppginf.cls** original foi criada
e é mantida pelo **Prof. Carlos A. Maziero** (`maziero@inf.ufpr.br`). -
Suas fontes originais, históricos e instruções em LaTeX puro podem ser
encontradas em sua [página no
Wiki](http://wiki.inf.ufpr.br/maziero/doku.php?id=software:latex) e no
repositório do [GitLab C3SL](https://gitlab.c3sl.ufpr.br/maziero/tese).

**Aprimoramentos do pacote:** O *ufprdown* abstrai a complexidade do
LaTeX e resolve automatizadamente através da linguagem R e do Pandoc
diversas “pendências” históricas listadas na estrutura do modelo
original. Destacam-se as seguintes resoluções contempladas por este
pacote:

- **Gerenciamento de metadados via YAML:** Você escreve seus dados
  apenas uma vez no arquivo principal.
- **Geração nativa de Listas:** Todas as listas de Siglas, Símbolos,
  Rótulos, bem como o Sumário, Ficha Catalográfica e Folha de Aprovação
  são invocados automaticamente.
- **Inteligência de Modos:** Ao alternar o parâmetro `final_mode` entre
  `false` (banca) ou `true` (final), o ufprdown ativa e desativa (sem
  você saber LaTeX) a presença das páginas pré-textuais e de aprovações.
- **Multi-arquivos:** Distribuição isolada de conteúdo em arquitetura de
  capítulos do `bookdown`.
- **Separação Quadros vs Tabelas:** O template resolve a diferenciação
  semântica e tipográfica entre tabelas genéricas e quadros textuais
  dentro do engine do RMarkdown.
- **Apêndices e Anexos independentes:** Fluxos de contagem automatizados
  e divididos para Apêndices e Anexos.

O ufprdown segue o conceito de pacotes pioneiros da cena internacional,
como o [thesisdown](https://github.com/ismayc/thesisdown) (Chester
Ismay) e do brasileiro [ufscdown](https://github.com/lfpdroubi/ufscdown)
(Luiz Droubi). Ele, contudo, é um pacote desenvolvido do zero, pensado
única e exclusivamente para lidar com a semântica da UFPR. E o mais
importante: preserva de forma canônica os arquivos `.cls` originais do
professor Maziero sem nenhuma adulteração. Para mais detalhes, consulte
o [README do pacote](https://github.com/evandeilton/ufprdown) e a
documentação da classe **ppginf.cls** (PPGInf/UFPR).
