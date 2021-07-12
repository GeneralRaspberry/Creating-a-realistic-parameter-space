#Creating a table

library(officer)
library(flextable)
library(magrittr)

# Create flextable object
ft <- flextable(data = parameter_table) %>% 
  theme_zebra %>% 
  autofit
# See flextable in RStudio viewer
ft

# Create a temp file
tmp <- tempfile(fileext = ".docx")

# Create a docx file
read_docx() %>% 
  body_add_flextable(ft) %>% 
  print(target = tmp)

# open word document
browseURL(tmp)