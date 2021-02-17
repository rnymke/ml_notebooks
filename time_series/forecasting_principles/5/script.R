library(fpp2)

data("elecdaily")

data <- elecdaily %>% head(20)
data %>% head()
autoplot(data)

qplot(Temperature, Demand, data=as.data.frame(data))

mdl <- tslm(Demand ~ Temperature, data=data)
checkresiduals(mdl)

low_scenario <- forecast(mdl, data.frame('Temperature' = 15))
high_scenario <- forecast(mdl, data.frame('Temperature' = 30))

# Low, high scenario including prediction interval
autoplot(forecast(data[,1])) +
  autolayer(low_scenario, PI=T, series='decrease') +
  autolayer(high_scenario, PI=T, series='increase')

# Clearly using 20 points is bad
ggplot(data = as.data.frame(elecdaily), aes(x=Temperature, y=Demand)) +
  geom_point()


data("mens400")
autoplot(mens400)

time_mens400 <- time(mens400)
mdl <- tslm(mens400 ~ time_mens400)
checkresiduals(mdl)

fc_layer <- forecast(mdl, newdata=data.frame('time_mens400' = c(2020)))

autoplot(mens400) +
  autolayer(fc_layer, PI=T)



# fancy
autoplot(fancy)

lgf <- log(fancy)
