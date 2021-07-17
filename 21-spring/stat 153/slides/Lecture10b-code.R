a = arima.sim(n=100,model=list(ma=.8))
acf(a)
abline(h=0.5,col='red')


plot.ts(JohnsonJohnson)
arima(JohnsonJohnson,order=c(1,0,3))
arima(JohnsonJohnson,order=c(1,0,3),method="CSS") # either method may have convergence issues
arima(JohnsonJohnson,order=c(1,0,3),method="ML")

###
### Data example
###
library(astsa)
plot.ts(cardox)


### Or
a = arima(cardox,order=c(0,1,1),seasonal=list(order=c(0,1,1),period=12))
par(mfrow=c(1,1))
# plot.ts(a$residuals)
acf2(a$residuals)
# pacf(a$residuals)

### Diagnostic plots with SARIMA, starting with all 0's. 
s1 = sarima(cardox,p=0,d=1,q=1,P=0,D=1,Q=1,S=12)
s3 = sarima(cardox,p=0,d=1,q=3,P=0,D=1,Q=1,S=12)


### Auto.arima?
library(forecast)
auto.arima(cardox)


# choose auto.arima's model
s2= sarima(cardox,p=1,d=1,q=1,P=2,D=1,Q=2,S=12)

# compare AICc's
s1$AIC
s2$AIC

# why isn't auto.arima's the best? 
?auto.arima
# It's searching over a large but limited number of different combinations! 

# Let P=1. Note the optim error we recieve
s2= sarima(cardox,p=1,d=1,q=1,P=1,D=1,Q=2,S=12)
