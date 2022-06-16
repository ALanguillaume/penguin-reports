
library(purrr)

render_reports <- function(dataset, island, output_dir) {
  rmarkdown::render(
    input = "template.Rmd",
    output_file = paste0(island, ".html"),
    output_dir = output_dir,
    quiet = TRUE,
    params = list(
      dataset = dataset, 
      island = island
    )
  )
}

l_files <- list.files(
  path = "data/",
  pattern = ".csv$",
  full.names = TRUE
) 

l_islands <- l_files %>% 
  basename() %>% 
  tools::file_path_sans_ext()

l_datasets <- map(
  l_files,
  readr::read_csv,
  show_col_types = FALSE
) 

walk2(
  l_datasets, 
  l_islands,
  render_reports,
  output_dir = "reports/"
)
