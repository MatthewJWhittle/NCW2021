rm(list = ls())

require(tidyverse)

data <- read_csv("city_temperature.csv")

data <-
    data %>% 
    mutate(AvgTemperature = if_else(AvgTemperature <= -99, true = NA_real_, false = AvgTemperature)) %>% 
    filter(Year >= 1995)

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


# hist(data$AvgTemperature)
monthly_means <-  
    data %>% 
    group_by(Region, Country, State, City, Year, Month) %>% 
    summarise(monthly_average = mean(AvgTemperature, na.rm = TRUE))

monthly_means %>% write_csv("data/monthly-mean-temps.csv")

data %>% write_csv("city_temperature_tidy.csv")
