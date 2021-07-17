## White noise
Zt = rnorm(100)
plot.ts(Zt)
acf(Zt)
pacf(Zt)
# we can easily plot both of them together
library(astsa)
acf2(Zt) 
# acf2() skips the lag 0 values of the acf, as this is always 1 and not informative anyway. 
# Note 2: see the numbers in the console? acf2() outputs the acf and pacf values. Not saved, so printed to screen. 
a = acf2(Zt) # stores that output in a instead of printing to screen


### The following processes are not stationary. Note that we must check the plot of the process and it's P/ACF. 

## Trend
t = 1:100
plot.ts(t+ Zt)
a = acf2(t+ Zt)

## Seasonality
st = (t%%4) 
plot.ts(st+ Zt)
a = acf2(st+ Zt)

### Now we look at stationary processes, particularly ARMA(p,q).
### Note the effect of sample size


## MA(q)
MAq = arima.sim(n=100,model=list(ma=c(.9,0,-.2)))
plot.ts(MAq)
a = acf2(MAq)

## MA(q), n=1000
MAq1000 = arima.sim(n=1000,model=list(ma=c(.8,.4,.2)))
a = acf2(MAq1000)
#q=3 is visible!
  
## AR(p)
ARp = arima.sim(n=100,model=list(ar=c(.9,-.5,-.2)))
plot.ts(ARp)
a = acf2(ARp)

## AR(p), n=1000
ARp1000 = arima.sim(n=1000,model=list(ar=c(.9,0,-.2)))
a = acf2(ARp1000)
#p=???
  
## ARMA(p,q)
ARMA = arima.sim(n=100,model=list(ar=c(.9,0,-.2),ma=c(.9,0,-.2)))
a = acf2(ARMA)

## ARMA(p,q), n=1000
ARMA1000 = arima.sim(n=1000,model=list(ar=c(.9,0,-.2),ma=c(.9,0,-.2)))
a = acf2(ARMA1000)
#p=???, q=???
  
