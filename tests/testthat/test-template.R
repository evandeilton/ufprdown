test_that("o template thesis compila em PDF nas fontes padrao e alternativas", {
    skip_on_cran()

    # Preparar pasta temporária para evitar lixo
    test_dir <- tempfile("tests-ufprdown-")
    dir.create(test_dir)
    on.exit(unlink(test_dir, recursive = TRUE))

    # Cria o draft
    rmarkdown::draft(
        file.path(test_dir, "index.Rmd"),
        template = "thesis",
        package = "ufprdown",
        create_dir = FALSE,
        edit = FALSE
    )

    # Renomeia se necessário ou seta index_file
    index_file <- file.path(test_dir, "index.Rmd")
    expect_true(file.exists(index_file))

    # Parâmetros variáveis para compilação minimalista
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

    lines <- readLines(index_file)
    end_yaml <- which(lines == "---")[2]
    yaml_lines <- lines[2:(end_yaml - 1)]
    body_lines <- lines[(end_yaml + 1):length(lines)]

    doc <- yaml::yaml.load(paste(yaml_lines, collapse = "\n"))

    for (i in seq_len(nrow(test_cases))) {
        doc$doc_type <- test_cases$doc_type[i]
        doc$level <- test_cases$level[i]
        doc$doc_mode <- test_cases$doc_mode[i]
        doc$final_mode <- test_cases$final_mode[i]
        doc$element_names_up <- test_cases$element_names_up[i]
        doc$fig_caption_position <- test_cases$fig_caption_position[i]
        doc$`font-family` <- test_cases$font_family[i]

        if (doc$final_mode == TRUE) {
            doc$thanks <- "Agradeco aos testes."
            doc$dedication <- "Dedico ao CRAN."
        } else {
            doc$thanks <- NULL
            doc$dedication <- NULL
        }

        out_name <- sprintf(
            "pdf_T%02d_%st.pdf", # t for test
            i,
            gsub(" ", "_", test_cases$font_family[i])
        )

        new_yaml_str <- yaml::as.yaml(doc)
        output_lines <- c("---", strsplit(new_yaml_str, "\n")[[1]], "---", body_lines)
        writeLines(output_lines, index_file)

        bd_config <- yaml::yaml.load_file(file.path(test_dir, "_bookdown.yml"))
        bd_config$book_filename <- tools::file_path_sans_ext(out_name)
        writeLines(yaml::as.yaml(bd_config), file.path(test_dir, "_bookdown.yml"))

        # Compilação
        owd <- setwd(test_dir)
        tryCatch({
            bookdown::render_book("index.Rmd", "ufprdown::thesis_pdf", quiet = TRUE)
        }, error = function(e) {
            log_name <- paste0(tools::file_path_sans_ext(out_name), ".log")
            if (file.exists(log_name)) {
                log_content <- paste(readLines(log_name), collapse = "\n")
                if (nchar(log_content) > 3000) {
                  log_content <- paste("...[truncado]...\n", substr(log_content, nchar(log_content) - 3000, nchar(log_content)))
                }
                e$message <- paste0(e$message, "\n\n====== LATEX LOG ERROR ======\n", log_content, "\n=============================\n")
            } else {
                e$message <- paste0(e$message, "\n\n====== NO LOG FILE FOUND IN ", getwd(), " ======\nLogs disponiveis: ", paste(list.files(pattern = "\\.log$"), collapse=", "))
            }
            stop(e)
        }, finally = {
            setwd(owd)
        })

        pdf_path <- file.path(test_dir, "_book", out_name)
        expect_true(file.exists(pdf_path))
    }
})
