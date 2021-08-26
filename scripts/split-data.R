rm(list = ls())

require(tidyverse)

data <- read_csv("city_temperature.csv")

regions <- unique(data$Region)

file_ids <- regions %>% 
str_replace_all("/| |[[:punct:]]", "-") %>% 
str_replace_all("-+", "-") %>%
str_to_lower()


map2(
    regions, 
    file_ids, 
    ~data %>% 
    filter(Region == .x) %>% 
    write_csv(glue::glue("data/daily-temperature-{.y}.csv")))
