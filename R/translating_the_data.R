library(tidyverse)
library(googleLanguageR)
library(readxl)
library(xlsx)

#gets vector and return translation table
translate_to_eng <- function(string_vector,re_translate=F){
  
  googleLanguageR::gl_auth("credentials/mor translation 007-a1c7132b0eec.json")
  
  
  #check if translation already present:
  files_names <- list.files("data/")
  translation_exists <- "text_trans.csv" %in% files_names
  transltion_name=paste0("data/text_trans.csv")
  
  if (!translation_exists) {
    my_translation <- gl_translate(string_vector, target = "en", format = "text")
    
    write_excel_csv(my_translation,transltion_name)
    
  } else if (re_translate){
    my_translation <- gl_translate(string_vector, target = "en", format = "text")
    
    write_excel_csv(my_translation,transltion_name)
    
  } else {
    
    my_translation <- suppressMessages(read_csv("data/text_trans.csv"))
  }
  
  
  
  
  return(my_translation)
}



data_for_translation <- readRDS("data/parsed_data.rds") 

translted_output <- translate_to_eng(data_for_translation$raw_text) %>% 
  left_join(data_for_translation %>% 
              mutate(raw_text=str_sub(raw_text,end=-4)),
            by=c("text"="raw_text"))


write_excel_csv(translted_output,"export/poussin_letters_translated_1.csv")
