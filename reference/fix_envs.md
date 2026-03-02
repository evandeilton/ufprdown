# Corrige ambientes LaTeX

Função interna que remove linhas em branco extras ao redor de ambientes
LaTeX gerados pelo pandoc, evitando espaçamento indesejado no PDF.

## Usage

``` r
fix_envs(x)
```

## Arguments

- x:

  Vetor de caracteres com as linhas do arquivo LaTeX.

## Value

Vetor de caracteres modificado.
