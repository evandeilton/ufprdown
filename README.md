# ufprdown <img src="man/figures/logo.png" align="right" height="120" />

<!-- badges: start -->
<!-- badges: end -->

**Pacote R para escrever teses e dissertações na UFPR usando R Markdown.**

O `ufprdown` utiliza o [bookdown](https://bookdown.org/) e a classe LaTeX
`ppginf.cls` do [PPGInf/UFPR](https://www.inf.ufpr.br/ppginf/) para gerar
documentos acadêmicos no formato exigido pela Universidade Federal do Paraná,
com código R embutido para análises e gráficos reprodutíveis.

**Importante:** O arquivo `ppginf.cls` é o template oficial do PPGInf/UFPR e
**não deve ser modificado** — ele contém os padrões de formatação da UFPR
(margens, capa, folha de rosto, listas, numeração etc.). O pacote ufprdown
utiliza uma cópia idêntica da classe oficial; personalizações devem ser feitas
apenas no YAML, no `template.tex` ou em `setup/packages.tex`.

## ✨ Funcionalidades

- 📄 **PDF** seguindo o template oficial da UFPR (`ppginf.cls`)
- 🌐 **HTML** interativo via gitbook
- 📝 **Word** para revisão
- 📱 **epub** para leitura em dispositivos móveis
- 🔬 **Reprodutível**: código R embutido gera gráficos e tabelas automaticamente
- 🎨 **Capa** com imagem de fundo personalizável
- 📚 **Bibliografia** no formato ABNT/apalike-ptbr

## 📦 Instalação

```r
# Instalar dependências
install.packages(c("bookdown", "knitr", "rmarkdown", "devtools"))

# Instalar o ufprdown localmente
devtools::install("/caminho/para/ufprdown")

# Ou, se publicado no GitHub:
# remotes::install_github("evandeilton/ufprdown")
```

## 🚀 Como usar

### Via RStudio

1. Instale o pacote conforme acima
2. **File → New Project → New Directory**
3. Selecione **"Tese UFPR"** na lista de templates
4. Escolha o diretório e clique em **Create Project**
5. Clique em **Build Book** ou use `Ctrl+Shift+B`

### Via console R

```r
library(ufprdown)

# Compilar o PDF da tese
bookdown::render_book("index.Rmd", "ufprdown::thesis_pdf")

# Compilar versão web (gitbook)
bookdown::render_book("index.Rmd", "ufprdown::thesis_gitbook")
```

## 📁 Estrutura do projeto

Ao criar um novo projeto com o template, a seguinte estrutura é gerada:

```
minha-tese/
├── index.Rmd              ← Arquivo principal (YAML + Introdução)
├── 00-abstract.Rmd        ← Resumo (PT)
├── 00-foreignabstract.Rmd ← Abstract (EN)
├── 00--prelim.Rmd         ← Elementos pré-textuais (HTML)
├── 01-chap1.Rmd           ← Cap. 1: Fundamentação Teórica
├── 02-chap2.Rmd           ← Cap. 2: Revisão de Literatura
├── 03-chap3.Rmd           ← Cap. 3: Metodologia
├── 04-chap4.Rmd           ← Cap. 4: Resultados
├── 96-conclusion.Rmd      ← Conclusão
├── 97-references.Rmd      ← Referências
├── 98-appendix.Rmd        ← Apêndices
├── _bookdown.yml          ← Configuração do bookdown
├── template.tex           ← Template LaTeX (Pandoc → ppginf)
├── ppginf.cls             ← Classe UFPR
├── apalike-ptbr.bst       ← Estilo bibliográfico (PT-BR)
├── lista_siglas.tex       ← Lista de acrônimos
├── lista_simbolos.tex     ← Lista de símbolos
├── Ficha_Catalografica.pdf
├── aprovacao.pdf
├── bib/                   ← Arquivos de bibliografia
│   ├── references.bib
│   ├── thesis.bib
│   └── pkgs.bib
├── setup/                 ← Configuração LaTeX
│   ├── packages.tex
│   └── fundo-capa.png
├── figure/                ← Figuras estáticas
├── images/                ← Figuras geradas pelo R
├── csl/apa.csl            ← Estilo de citação
└── data/                  ← Dados de exemplo
```

## ⚙️ Campos YAML disponíveis

No cabeçalho do `index.Rmd`, os seguintes campos controlam a tese:

| Campo | Descrição | Exemplo |
|---|---|---|
| `author` | Nome do autor | José Evandeilton Lopes |
| `advisor` | Orientador | Prof. Wagner Hugo Bonat, PhD |
| `coadvisor` | Coorientador (opcional) | — |
| `institution` | Instituição por extenso | Universidade Federal do Paraná |
| `inst_short` | Sigla da instituição | UFPR |
| `field` | Área de concentração | Métodos Numéricos em Engenharia |
| `local` | Local | Curitiba PR |
| `date_year` | Ano | 2026 |
| `doc_type` | Tipo | Tese / Dissertação / Qualificação |
| `level` | Nível | doutorado / mestrado |
| `descr` | Descrição na folha de rosto | Tese apresentada como... |
| `doc_mode` | Versão | defesa / final |
| `coverimage` | Imagem da capa | setup/fundo-capa.png |
| `title` | Título do trabalho | Modelos de Regressão Beta... |
| `palavras-chave` | Palavras-chave (PT) | Regressão beta. Efeitos mistos... |
| `keywords` | Keywords (EN) | Beta regression. Mixed effects... |

## 🔧 Requisitos do sistema

- **R** ≥ 3.5.0
- **RStudio** (recomendado)
- **pandoc** ≥ 2.0
- **LaTeX**: TeX Live ou TinyTeX (`tinytex::install_tinytex()`)
- Pacotes R: `bookdown`, `knitr`, `rmarkdown`

## 📝 Versão de defesa vs. final

- **`doc_mode: 'defesa'`**: espaçamento 1,5; sem ficha catalográfica, aprovação,
  dedicatória nem agradecimentos; indicação de data de compilação.
- **`doc_mode: 'final'`**: espaçamento simples; todos os elementos pré-textuais
  incluídos; pronto para depósito na biblioteca.

**Atenção (modo final):** Nos campos `thanks` e `dedication` do YAML, **não use
`| ` no início de cada linha**. Esse formato é interpretado pelo Pandoc como
lista e gera `\item` no LaTeX, causando o erro "Lonely \\item". Use apenas
quebra de linha, por exemplo:

```yaml
thanks: |
  Agradeço a Deus...
  Ao meu orientador...
```

## 🙏 Créditos

- Classe `ppginf.cls`: Prof. Carlos A. Maziero, DInf/UFPR — template oficial do
  PPGInf/UFPR; **não modificar** (contém os padrões da UFPR).
- Baseado no [thesisdown](https://github.com/ismayc/thesisdown) e
  [ufscdown](https://github.com/lfpdroubi/ufscdown)
- [bookdown](https://bookdown.org/) por Yihui Xie

## 📄 Licença

MIT © 2026 José Evandeilton Lopes
