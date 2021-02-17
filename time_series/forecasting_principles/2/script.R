library(forecast)
library(readxl)

path = "C:/Users/rnydestedt/Repositories/ml_projects/time_series/forecasting_principles/2/"

# Ex 1§
autoplot(gold)
which.max(gold)

# Ex 2
tute_raw <- read.csv(paste0(path, "tute1.csv"), header=T)
tute = ts(tute_raw[,-1], start=1981, frequency=4)
autoplot(tute, facets=T)

# Ex 3
retail_raw <- readxl::read_excel(paste0(path, "retail.xlsx"), skip=1)
retail_raw %>% View
retail_raw %>% names

retail = ts(retail_raw[,5], frequency=12, start=c(1982,4)) # Col 5, arbitrarly chosen

autoplot(retail)

ggseasonplot(retail)

ggsubseriesplot(retail)

gglagplot(retail)

ggAcf(retail)

# Basically every plot shows it's super autocorrelated,
# makes sense given the strong upwards trend
