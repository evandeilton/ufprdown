# ufprdown: Pacote para criar dissertações e teses na UFPR usando R Markdown

O pacote ufprdown fornece um template R Markdown para produzir
dissertações e teses na Universidade Federal do Paraná (UFPR), seguindo
as diretrizes de formatação da classe LaTeX ppginf.cls do PPGInf/UFPR. O
pacote utiliza o bookdown como motor de compilação, permitindo pesquisa
reprodutível com código R embutido para gráficos e análises.

## thesis_pdf

Gera a tese em formato PDF seguindo o template UFPR

## thesis_gitbook

Gera a tese como página web interativa

## thesis_word

Gera a tese em formato Microsoft Word

## thesis_epub

Gera a tese em formato ebook (epub)

## Uso

Após instalar o pacote, o template aparece em: *File \> New Project \>
New Directory \> Tese UFPR*

Ou compile diretamente via console R:

    bookdown::render_book("index.Rmd", "ufprdown::thesis_pdf")

## Campos YAML

Os seguintes campos estão disponíveis no cabeçalho YAML:

- author:

  Nome completo do autor

- advisor:

  Nome do orientador

- coadvisor:

  Nome do coorientador (opcional)

- institution:

  Nome da instituição por extenso

- inst_short:

  Sigla da instituição (ex: UFPR)

- field:

  Área de concentração

- local:

  Cidade e estado (ex: Curitiba PR)

- date_year:

  Ano da defesa

- doc_type:

  Tipo de documento: Tese, Dissertação, Trabalho de Conclusão de Curso
  ou Qualificação

- level:

  Nível: doutorado ou mestrado

- descr:

  Descrição para folha de rosto

- doc_mode:

  Versão: defesa ou final

- coverimage:

  Caminho para imagem de fundo da capa

- title:

  Título da tese

- palavras-chave:

  Palavras-chave em português

- keywords:

  Palavras-chave em inglês

## Author

**Maintainer**: José Evandeilton Lopes <evandeilton@gmail.com>

Other contributors:

- Chester Ismay (Original thesisdown author) \[contributor\]

- Luiz Droubi (ufscdown author) \[contributor\]
