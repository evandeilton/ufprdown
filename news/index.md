# Changelog

## ufprdown 0.1.4

- **Correção crítica:** removido `\bibliography{}` de
  `97-references.Rmd` que conflitava com o pandoc citeproc e causava
  duplicação ou ausência das referências no PDF. Adicionado heading
  `# Referências {-}` e âncora `<div id="refs">` para posicionamento
  correto antes dos apêndices.
- **Correção de títulos estruturais:** SUMÁRIO, LISTA DE FIGURAS, LISTA
  DE TABELAS, LISTA DE QUADROS, LISTA DE SIGLAS, LISTA DE SÍMBOLOS,
  REFERÊNCIAS e APÊNDICE agora são **sempre** em caixa alta por norma
  ABNT/UFPR, independente do valor de `element_names_up`. O parâmetro
  `element_names_up` passa a controlar exclusivamente os prefixos de
  legenda (FIGURA vs Figura, TABELA vs Tabela, QUADRO vs Quadro).
- **Correção de conflito `\@taganexo`:** removida definição duplicada de
  `\@taganexo` em `setup/packages.tex` que causava erro de compilação
  quando `element_names_up: true`.
- **Correção de `\CSLRightInline`:** substituído
  `\linewidth - \csllabelwidth` por
  `\dimexpr\linewidth-\csllabelwidth\relax` evitando erro de dimensão em
  algumas versões do LaTeX.
- **Remoção de arquivo duplicado:** `setup/ppginf.cls` (cópia nunca
  utilizada pelo LaTeX) foi removido.
- **Reorganização de `\RequirePackage{comment}`:** movido para
  `setup/packages.tex` na posição correta após `\documentclass`.

## ufprdown 0.1.3

- Correção drástica de um problema originário do pacote `rmarkdown` onde
  a função `draft(...)` renomeava automaticamente o `skeleton.Rmd`
  primário, quebrando o comportamento obrigatório de inicialização
  indexada do `bookdown`. Um proxy inteligente chamado `skeleton.Rmd`
  (Descartável) foi criado ao passo que o código real agora se encontra
  em um `index.Rmd` seguro na pasta template.
- Removido o argumento redundante e deflator `doc_mode` do YAML (que
  causava o erro irrecuperável `Lonely \item` ou
  `Undefined control sequence. \MT@patch@undo` se os usuários o
  desincronizassem). Toda a inteligência da classe `ppginf.cls` e os
  itens pré-textuais LaTeX agora obedecem unicamente à true/false na
  flag `final_mode` no `template.tex`.
- Atualizada a documentação de Créditos.

## ufprdown 0.1.2

- Documentação atualizada alertando sobre a exigência primária de uma
  intalação de distribuição LaTeX Completa (Full texlive/miktex) para
  correto processamento e evitação do erro restritivo do pdf latex
  (Fatal error occurred, no output PDF file produced).
- Remoção temporária do R-CMD-check contínuo e infraestrutura testthat
  do ecossistema devido a falhas e limitações do container de
  bibliotecas isoladas online executarem pacotes grandes e base fonts
  UFPR sem estourar compilação.
- Site/Github Pages (pkgdown) do pacote parametrizado com fontes Serif
  (Times New Roman).

## ufprdown 0.1.1

- Adiciona a opção `font-family` no YAML template base, permitindo
  alternar de forma nativa a fonte do trabalho acadêmico (são opções
  válidas: `'Times New Roman'` ou `'Arial'`). Resolve um problema
  recorrente nos templates que exigia troca manual de pacotes e sintaxe
  (via ou helvet).
- Adiciona controle avançado que traduz as expressões geradas
  nativamente por RMarkdown, Bookdown, LaTeX ( , , ) e Babel. Com o
  argumento `element_names_up: true`, todos os itens listados (`FIGURA`,
  `TABELA`, `LISTA DE TABELAS`, `SUMÁRIO`, `REFERÊNCIAS`, `APÊNDICE` e
  `ANEXO`) são convertidos de forma automática para Português em caixa
  alta conforme exige as atualizações de norma e formatação da
  PPGInf/UFPR (sem o padrão uppercase em inglês gerado incorretamente
  nas compilações antigas).
- A posição das em Figuras passa a aceitar o alinhamento configurável na
  flag `fig_caption_position`, o que permite alinhamento Top (como
  esperado) burlando o comportamento default base da macro original
  Pandoc.
- Documentação atualizada (README e vignettes) com o uso da
  `font-family` e o seu default `'Times New Roman'`.

## ufprdown 0.1.0

- Lançamento inicial do pacote com esqueleto de teses/dissertações da
  Universidade Federal do Paraná (PPGInf).
