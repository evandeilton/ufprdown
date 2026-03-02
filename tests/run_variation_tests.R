# Script em R para iterar todas as combinações de parâmetros solicitados

library(rmarkdown)
library(bookdown)
library(yaml)
library(ufprdown)

# Mudar diretório de trabalho para a pasta do teste
setwd("/home/jlopes/Dropbox/Pacotes/Dev/ufprdown/tests/tests-ufprdown")

# Parâmetros variáveis para compilação
test_cases <- data.frame(
  id = 1:2,
  doc_type = c("Tese", "Tese"),
  level = c("doutorado", "doutorado"),
  doc_mode = c("defesa", "final"),
  final_mode = c(FALSE, TRUE),
  element_names_up = c(TRUE, TRUE),
  fig_caption_position = c("top", "bottom"),
  font_family = c("Arial", "Times New Roman")
)

# Ler o cabeçalho original (apenas a primeira porção para parse YAML)
index_file <- "index.Rmd"
lines <- readLines(index_file)
# YAML está entre as duas tralhas "---"
end_yaml <- which(lines == "---")[2]
yaml_lines <- lines[2:(end_yaml - 1)]
body_lines <- lines[(end_yaml + 1):length(lines)]

doc <- yaml.load(paste(yaml_lines, collapse = "\n"))

# Criação das compilações de testes
for (i in seq_len(nrow(test_cases))) {
  # Carregar os parcerros
  doc$doc_type <- test_cases$doc_type[i]
  doc$level <- test_cases$level[i]
  doc$doc_mode <- test_cases$doc_mode[i]
  doc$final_mode <- test_cases$final_mode[i]
  doc$element_names_up <- test_cases$element_names_up[i]
  doc$fig_caption_position <- test_cases$fig_caption_position[i]
  doc$`font-family` <- test_cases$font_family[i]

  if (doc$final_mode == TRUE) {
    doc$thanks <- "Agradeço aos meus testes de R.\nAos paramêtros combinados."
    doc$dedication <- "Dedico este código ao CRAN."
  } else {
    doc$thanks <- NULL
    doc$dedication <- NULL
  }

  # Nome lógico de output
  out_name <- sprintf(
    "pdf_T%02d_%s.pdf",
    i,
    gsub(" ", "_", test_cases$font_family[i])
  )

  # Alterar o output filename do _bookdown.yml via variavel global
  # Para forçar o \bookdown\ a renomear
  # Escreve o novo index.Rmd mesclando o manipulado com YAML e o Body
  new_yaml_str <- as.yaml(doc)
  output_lines <- c("---", strsplit(new_yaml_str, "\n")[[1]], "---", body_lines)
  writeLines(output_lines, index_file)

  bd_config <- yaml::yaml.load_file("_bookdown.yml")
  bd_config$book_filename <- tools::file_path_sans_ext(out_name)
  writeLines(as.yaml(bd_config), "_bookdown.yml")

  cat(sprintf("\n🚀 TESTANDO CASO %d: %s (Fonte: %s)...\n", i, out_name, doc$`font-family`))
  tryCatch(
    {
      bookdown::render_book(index_file, "ufprdown::thesis_pdf", quiet = TRUE)
      cat(sprintf("✅ SUCESSO. Gravado como _book/%s\n", out_name))
    },
    error = function(e) {
      cat(sprintf("❌ FALHOU: %s\n", e$message))
    }
  )
}
