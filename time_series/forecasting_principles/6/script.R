library(fpp2)
#The plastics data set consists of the monthly sales (in thousands) of product A
#for a plastics manufacturer for five years.
#
#Plot the time series of sales of product A.
data <- plastics
autoplot(data)
#Can you identify seasonal fluctuations and/or a trend-cycle?
# # #
"Increasing trend, seasonality like a reflected x^2"
# # #

#  Use a classical multiplicative decomposition to calculate the trend-cycle
#and seasonal indices.
# # #
data %>% decompose(type="additive") %>% autoplot()
# # #
#Do the results support the graphical interpretation from part a?
"Yes"
#  Compute and plot the seasonally adjusted data.
seas <- data %>% decompose(type="additive")
autoplot(data, series="Original") +
  autolayer(seasadj(seas), series="Seaonsally adjusted")
#Change one observation to be an outlier (e.g., add 500 to one observation),
#and recompute the seasonally adjusted data. What is the effect of the outlier?
data_outlier <- data
data_outlier[30] <- data_outlier[30]+500
autoplot(data_outlier)
seas_outlier <- data_outlier %>% decompose(type="additive")
autoplot(data_outlier, series="Original") +
  autolayer(seasadj(seas_outlier), series="Seaonsally adjusted")
"Outlier is not captured when seasonally adjusting,
but overall appearance disregarding the outlier is similar"
#  Does it make any difference if the outlier is near the end rather than in
#the middle of the time series?

# Outlier at 1
data_outlier <- data
data_outlier[1] <- data_outlier[1]+500
autoplot(data_outlier)
seas_outlier <- data_outlier %>% decompose(type="additive")
autoplot(data_outlier, series="Original") +
  autolayer(seasadj(seas_outlier), series="Seaonsally adjusted")

# Outlier at 60
data_outlier <- data
data_outlier[60] <- data_outlier[60]+500
autoplot(data_outlier)
seas_outlier <- data_outlier %>% decompose(type="additive")
autoplot(data_outlier, series="Original") +
  autolayer(seasadj(seas_outlier), series="Seaonsally adjusted")
"Seems to be slightly more robust to outliers at the edge."
