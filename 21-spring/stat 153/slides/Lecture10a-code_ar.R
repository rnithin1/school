turkey = read.csv('~/Dropbox/2021-SPRING-STAT153/Datasets/Turkey.csv')

# First visually inspect data
plot.ts(turkey$Turkey)
 
# We note the main component is the large spikes every Nov.
# Thus we model the seasonality, and then look at the residuals
model1 = lm(Turkey ~ month, data=turkey)
plot.ts(model1$residuals)

# Residuals look odd, so we also look at the function's fit on the data
time=1:nrow(turkey)
plot(time,turkey$Turkey,type='o')
lines(time,model1$fitted.values,col=2)

# It appears there is a linear trend, so we add that to our model
model2 = lm(Turkey ~ month + time, data=turkey)

# Then inspect the new residuals and function fit
plot.ts(model2$residuals)
plot(time,turkey$Turkey,type='o')
lines(time,model2$fitted.values,col=2)

# The linear trend of the spikes appears to be a different 
# linear trend compared to the other months. R can fit 
# a different linear trend for each month with seasonal*trend, as seen below:
model3 = lm(Turkey ~ month*time, data=turkey)
plot(time,turkey$Turkey)
lines(time,model3$fitted.values,col=2)
plot.ts(model3$residuals)
# These points look fairly stationary (at least good enough for today's purposes!)

# Are they white noise?
acf(model3$residuals)
pacf(model3$residuals)

# Both acf and pacf have a significant spike at lag 1. 
# Let's assume ar(1)

ar(model3$residuals, aic=FALSE, order.max=1)
ar(model3$residuals, method = 'yw', aic=FALSE, order.max=1)
ar(model3$residuals, method = 'ols', aic=FALSE, order.max=1)
ar(model3$residuals, method = 'mle', aic=FALSE, order.max=1)

# note that method='ols' gets the same coefficient as regression
xt = model3$residuals[2:189]
xt_1 = model3$residuals[1:188]
lm(xt~xt_1)
a= ar(model3$residuals, method = 'ols', aic=FALSE, order.max=1)
a
# but note a's residuals
head(a$resid)

