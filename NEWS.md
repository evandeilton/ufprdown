# ufprdown 0.1.1

* Adiciona a opção `font-family` no YAML template base, permitindo alternar de forma nativa a fonte do trabalho acadêmico (são opções válidas: `'Times New Roman'` ou `'Arial'`). Resolve um problema recorrente nos templates que exigia troca manual de pacotes e sintaxe (via \usepackage{mathptmx} ou helvet).
* Adiciona controle avançado que traduz as expressões geradas nativamente por RMarkdown, Bookdown, LaTeX (\listoffigures, \listoftables, \listofquadros) e Babel. Com o argumento `element_names_up: true`, todos os itens listados (`FIGURA`, `TABELA`, `LISTA DE TABELAS`, `SUMÁRIO`, `REFERÊNCIAS`, `APÊNDICE` e `ANEXO`) são convertidos de forma automática para Português em caixa alta conforme exige as atualizações de norma e formatação da PPGInf/UFPR (sem o padrão uppercase em inglês gerado incorretamente nas compilações antigas).
* A posição das \captions em Figuras passa a aceitar o alinhamento configurável na flag `fig_caption_position`, o que permite alinhamento Top (como esperado) burlando o comportamento default base da macro original Pandoc.
* Documentação atualizada (README e vignettes) com o uso da `font-family` e o seu default `'Times New Roman'`.

# ufprdown 0.1.0

* Lançamento inicial do pacote com esqueleto de teses/dissertações da Universidade Federal do Paraná (PPGInf).
