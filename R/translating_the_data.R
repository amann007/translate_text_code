library(tidyverse)
library(translateR)

data_for_translation <- readRDS("data/parsed_data.rds")

getGoogleLanguages()

google.dataset.out.fr <- translate(dataset = data_for_translation,
                                content.field = 'raw_text',
                                google.api.key = my.api.key,
                                source.lang = 'fr',
                                target.lang = 'en')


google.dataset.out.it <- translate(dataset = data_for_translation,
                                    content.field = 'raw_text',
                                    google.api.key = my.api.key,
                                    source.lang = 'it',
                                    target.lang = 'en')