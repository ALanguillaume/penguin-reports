
library(purrr)

dataset <- palmerpenguins::penguins
l_datasets <- split(dataset, dataset$island)

l_datasets %>% 
  set_names(tolower(names(l_datasets))) %>% 
  iwalk(
    ~ readr::write_csv(
      x = .x, 
      file = file.path("data/", paste0(.y, ".csv"))
    )
  )
