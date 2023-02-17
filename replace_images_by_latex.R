library(magrittr)

tex_files <- list.files("Images/tex", pattern = ".tex.zip$", full.names = TRUE)
tex_nums <- readr::parse_number(tex_files)
names(tex_files) <- tex_nums
tex_chunks <- purrr::map(tex_files, readLines, warn = FALSE)
# tex_chunks <- purrr::map(tex_chunks, function(x) paste0("\\$",substr(x,4,nchar(x)-3),"\\$"))
qmd_files <- list.files(".", pattern = ".qmd$", full.names = TRUE)
qmd_texts <- purrr::map(qmd_files, readLines, warn = FALSE)
names(qmd_texts) <- qmd_files


#boucle sur chaque fichier
res <- purrr::map(
  qmd_texts,
  function(qmd){
    pres_im <- grep(x = qmd, pattern = im, perl = TRUE)
    # Boucle sur les lignes du fichier ayant des images
    res_one_file <- purrr::map(
      pres_im,
      function(num_line){
        images_line <- gregexpr(text = qmd[num_line], pattern = im, perl = TRUE)
        number_images <- length(images_line[[1]])
        res_line <<- qmd[num_line]
        for(n in 1:number_images){
          image_line <- gregexpr(text = res_line, pattern = im, perl = TRUE)[[1]]
          st <- image_line[1]
          len <- attr(image_line, which = "match.length")[1]
          #boucle sur chaque image de la ligne
          text_im <- substr(res_line, st, st+len-1)
          text_im <- gsub(x = text_im, pattern = "[)].*",replacement =  ")")
          num_eq <- readr::parse_number(text_im)
          eq <- tex_chunks[[as.character(num_eq)]]
          if(st==1){
            if((st+len)==nchar(res_line)){
              res_line <<- eq
            }else{
              res_line <<- paste0(eq, substring(res_line, st+len-1))
            }
          }else{
            if((st+len)==nchar(res_line)){
              res_line <<- paste0(substring(res_line, 1, st-1), eq)
            }else{
              res_line <<- paste0(substring(res_line, 1, st-1), eq, substring(res_line, st+len-1))
            }
          }
        }
        return(list(num=num_line,old=qmd[num_line],new=res_line))
      }
    )
    names(res_one_file) <- as.character(pres_im)
    return(res_one_file)
  }
)

purrr::walk(
  qmd_files,
  function(qmd){
    lines <- names(res[[qmd]])
    purrr::walk(
      lines,
      function(l){
        new <- res[[qmd]][[as.character(l)]]$new
        qmd_texts[[qmd]][as.integer(l)] <<- new
      }
    )
  }
)


purrr::iwalk(
  qmd_texts,
  function(text, file) writeLines(text, paste0(gsub(".qmd$","",file),"_with_tex.qmd")) 
)


# qmd = "./XX-microdata_copie.qmd"
# qmd_texts$`./XX-microdata_copie.qmd`[271] <- res$`./XX-microdata_copie.qmd`[["271"]]$new



