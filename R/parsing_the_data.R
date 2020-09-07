library(tidyverse)


data_raw <- readLines(con <- file("data/Poussin.html", encoding = "utf-8"))
close(con)

#ISO-8859-1

sliced_data <- str_split(data_raw[[3]],pattern = "<hr>")

sliced_data2 <- str_split(sliced_data[[1]],pattern = "<hr>")



sliced_data_tib <- as_tibble(sliced_data2,.name_repair = "unique") %>% 
  rowid_to_column() %>% 
  pivot_longer(-rowid) %>%
  select(-rowid) %>% 
  rowid_to_column() %>%
  select(-name) %>% 
  rename(raw_text=value)


no_html <- sliced_data_tib %>% 
  #keeping the paragraph structures:
  mutate(raw_text=str_replace_all(raw_text,pattern = "</p>",replacement = "\n\n")) %>% 
  #removing all html:
  mutate(raw_text=str_remove_all(raw_text,pattern = "<.*?>")) %>% 
  #removing bad splitting:
  filter(raw_text!="") 


saveRDS(no_html,"data/parsed_data.rds")
