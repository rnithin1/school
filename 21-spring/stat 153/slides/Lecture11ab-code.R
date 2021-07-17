library(astsa)
library(TSA)

## J&J
plot.ts(JohnsonJohnson)
periodogram(JohnsonJohnson)
mvspec(JohnsonJohnson)

d = diff(JohnsonJohnson)
periodogram(d) #differencing removes the low frequency events (i.e. trend)
mvspec(d) #axis is weird, but shows there is an annual effect and noise
# frequency=1/4, once every four months. 


## MA(1) Spectral distribution
fx = function(lambda,theta){
  1 + theta^2 + 2*theta*cos(2*pi*lambda)
}
curve(fx(x,theta=0.5),from=0,to=0.5)
arma.spec(ma=0.5)
plot.ts(arima.sim(n=100,model=list(ma=0.5)))

# End Lecture 11a

# Start code for Lecture 11b

## AR(1)
arma.spec(ar = .49)
plot.ts(arima.sim(n=100,model=list(ar=.49)))

plot.ts(arima.sim(n=100,model=list(ar=-.49)))
arma.spec(ar = -.49)

## AR(2)

plot.ts(arima.sim(n=100,model=list(ar=c(.6,-.2))))
arma.spec(ar = c(.6,-.2))

## Some other AR(p)'s
set.seed(100)
ar = c(.5,-.49,.4)
arma.spec(ar = ar)
simulated.ar3 = arima.sim(n=90,model=list(ar=ar))
plot.ts(simulated.ar3)
abline(v=4*(1:13),col=2)
TSA::periodogram(simulated.ar3)
mvspec(simulated.ar3)
acf2(simulated.ar3)
sarima(simulated.ar3,p=3,d=0,q=0)

## 
ar = c(0,-.8,0,-.9) 
arma.spec(ar = ar)
abline(v = 1/6, col = "red") #1/6?
abline(v = 1/3, col = "blue") #1/3
# Try again
arma.spec(ar = ar)
abline(v = 0.16, col = "red") #1/6?
abline(v = 0.34, col = "blue") #1/3
# Simulate
set.seed(34)
plot.ts(arima.sim(n=50,model=list(ar=ar)))
abline(v = (1/0.16) * 1:10, col = "red") 
abline(v = (1/0.34) * 1:20, col = "blue")


## spec.ar
x = arima.sim(n=100000,model=list(ma=c(.6,-.2)))
arma.spec(ma=c(.6,-.2))
spec.ar(x)

