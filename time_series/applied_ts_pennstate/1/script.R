library(astsa) # See note 1 below

# First set
x=scan("quakes.dat")
x=ts(x) #this makes sure R knows that x is a time series

plot(x, type="b") #time series plot of x with points marked as "o"

lag1.plot(x,1) # Plots x versus lag 1 of x.

acf(x, xlim=c(1,19)) # Plots the ACF of x for lags 1 to 19

xlag1=lag(x,-1) # Creates a lag 1 of x variable. See note 2

y=cbind(x,xlag1) # See note 3 below

ar1fit=lm(y[,1]~y[,2])#Does regression, stores results object named ar1fit

summary(ar1fit) # This lists the regression results

plot(ar1fit$fit,ar1fit$residuals) #plot of residuals versus fits

acf(ar1fit$residuals, xlim=c(1,18)) # ACF of the residuals for lags 1 to 18


# Second set
x = ts(scan('cmort.dat'))
plot(x, type='b')

xdiff = diff(x,1)
plot(xdiff, type='o')

acf(xdiff)

xdifflag = lag(xdiff, -1)

y = cbind(xdiff, xdifflag)

mdl = lm(y[,1]~y[,2])

summary(mdl)
plot(mdl$fit,type='b')
plot(mdl$fit,mdl$residuals)
acf(mdl$residuals)
