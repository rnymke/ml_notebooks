library(fpp2)
library(EnvStats)
library(fpp)
#data(usnetelec)
#data(usgdp)
data(mcopper)
#data(enplanements)
data(cangas)


mc <- ts(mcopper, start=1960, frequency=12)

optlam = BoxCox.lambda(mc)
plot(mc)
autoplot(BoxCox(mc, lambda=0.2))



plot(cangas)
lam = BoxCox.lambda(cangas)
autoplot(BoxCox(cangas, lambda=lam))

path = "C:/Users/rnydestedt/Repositories/ml_projects/time_series/forecasting_principles/2/"
retail_raw <- readxl::read_excel(paste0(path, "retail.xlsx"), skip=1)
retail = ts(retail_raw[,5], frequency=12, start=c(1982,4)) # Col 5, arbitrarly chosen

autoplot(retail)
autoplot(BoxCox(retail, lambda=BoxCox.lambda(retail)))

beer = window(ausbeer, start=1992)
fc <- snaive(beer)
autoplot(fc)
res <- residuals(fc)
autoplot(res)

checkresiduals(fc)

# ret
tr <- window(retail, end=c(2003,12))
te <- window(retail, start=2004)
autoplot(retail) +
  autolayer(tr) + autolayer(te)
fc <- snaive(tr)
autoplot(fc)
accuracy(fc, te)
checkresiduals(fc)
