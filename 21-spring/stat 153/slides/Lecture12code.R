library(astsa)
plot.ts(Hare)
mvspec(Hare)
abline(v=.105,col=2)
abline(v=.085,col=3)
abline(v=.145,col=4)

time=0:90
f1 = .105
cos1 = cos(2*pi*f1*time)
sin1 = sin(2*pi*f1*time)
f2 = .085
cos2 = cos(2*pi*f2*time)
sin2 = sin(2*pi*f2*time)
f3 = .145
cos3 = cos(2*pi*f3*time)
sin3 = sin(2*pi*f3*time)

model1 = lm(Hare ~ cos1 + sin1 + cos2 + sin2 + cos3 + sin3)
plot.ts(Hare)
lines(1845:1935,model1$fitted.values,col='firebrick3')

# Residual plot... stationary? 
plot.ts(model1$residuals)

### Noise!
acf2(model1$residuals,max.lag = 40)
library(forecast)
auto.arima(model1$residuals)
model2 = arima(model1$residuals,order=c(0,0,2))

# plot all together
plot.ts(Hare)
full.fit = model1$fitted.values + fitted(model2) #sarima functions doesn't have fitted values...
lines(1845:1935,model1$fitted.values,col='firebrick3')
lines(1845:1935,full.fit,col='dodgerblue2')

### Forecast?

# to Forecast parametric signal function, we need dataframe of future signal function inputs. 
time=91:100
f1 = .105
cos1 = cos(2*pi*f1*time)
sin1 = sin(2*pi*f1*time)
f2 = .085
cos2 = cos(2*pi*f2*time)
sin2 = sin(2*pi*f2*time)
f3 = .145
cos3 = cos(2*pi*f3*time)
sin3 = sin(2*pi*f3*time)
sinusoids = data.frame(model.matrix(~cos1 + sin1 + cos2 + sin2 + cos3 + sin3))
signal.hat = predict(model1,newdata = sinusoids)


# Getting forecasts via sarima
s.hat = sarima.for(model1$residuals,p=0,d=0,q=2,n.ahead=10)
forecasts2 = signal.hat + s.hat$pred

# Getting forecasts via arima (started above)
a.hat = predict(model2,n.ahead = 10)
forecasts = signal.hat + a.hat$pred

# Plot both: they're the same!
plot.ts(Hare,xlim=c(1845,1945))
lines(1845:(1935+10),c(full.fit,forecasts),col='dodgerblue2')
lines(1845:(1935+10),c(full.fit,forecasts2),col='purple')

### We could instead use seasonal differencing

### Or what if we did assume the process is stationary?? 
auto.arima(ts(Hare,frequency = 10))
ar4 = arima(Hare,order=c(4,0,0))
plot.ts(Hare)
lines(fitted(ar4),col=2)  
