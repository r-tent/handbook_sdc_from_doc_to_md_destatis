library(magrittr)
dir.create("chapters")
brio::read_file("Handbook.md") |>
  stringr::str_split(pattern = "\n# ") |>
  unlist() |>
  purrr::iwalk(
    function(f, i){
      if(i == 1){
        chap <- "page_titre"
        f <- substring(f,3)
      }else{
        chap <- stringr::str_extract(f, "^.*\r") |> 
          stringr::str_remove("\r") |>
          stringr::str_replace_all("( |, )", "_")
      }
      file <- paste0("chapters/",chap,".qmd")
      # file.edit(file.path(file))
      writeLines(paste0("# ", f), con = file, sep = "\n")
    }
  )