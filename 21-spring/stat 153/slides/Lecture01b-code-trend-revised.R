# loads us pop data
uspop = read.csv("uspop.csv") 
# Makes the plot
plot(uspop$Year, uspop$numpop, pch=19, type = "p", xlab = "Year(once every ten years)", ylab = "US Population", main = "Population of the United States")

# Fit quadratic model
yearSq = uspop$Year^2 # must create squared term
model1 = lm(uspop$numpop~uspop$Year+yearSq) #Y~X1+X2
# add model1 to plot
lines(uspop$Year,model1$fitted.values,col='red',lwd=3)
# Residual plot
plot(uspop$Year,model1$residuals,type='o')

# Model will contain a indicator term
ww2 = ifelse(uspop$Year %in% c(1940,1950),1,0)
model2 = lm(uspop$numpop ~ uspop$Year + yearSq + ww2)
# plot the model fit
plot(uspop$Year, uspop$numpop, pch=19, type = "p", xlab = "Year(once every ten years)", ylab = "US Population", main = "Population of the United States")
lines(uspop$Year,model2$fitted.values,col='red',lwd=3)
# Residual Plot
plot(uspop$Year,model2$residuals,type='o')

###
model3 = lm(numpop ~ Year + I(Year^2),data=uspop)
newdata = data.frame(Year=c(2020,2030,2040,2050))
forecasts = predict(model3,newdata = newdata)
plot(uspop$Year, uspop$numpop, pch=19, type = "p"
     , xlim = c(1790,2050), ylim=c(0,max(forecasts))
     , xlab = "Year(once every ten years)", ylab = "US Population", main = "Population of the United States")
lines(c(uspop$Year,newdata$Year),c(model3$fitted.values,forecasts),col='red',lwd=2)







###
### Quarterly Earnings for J&J
###

plot.ts(JohnsonJohnson)
# pull time out of JJ and force into a vector
tt = as.vector(time(JohnsonJohnson))
model_jj_quad = lm(JohnsonJohnson ~ tt + I(tt^2))
# plot function
lines(tt,model_jj_quad$fitted.values,col='blue',lwd=3)
# Residuals
plot(tt,model_jj_quad$residuals)


###
### Sales
###

sales = read.csv('~/Dropbox/Teaching/STAT 153/Project/sales.csv')
plot.ts(sales$sales)
model9 = lm(sales ~ poly(X,degree=12),data=sales)
lines(sales$X,model9$fitted.values,col='purple',lwd=3)
newdata = data.frame(X=1643:1800)
forecasts9 = predict(model9,newdata = newdata)

plot.ts(sales$sales,xlim=c(0,2000),ylim=c(-200,200))

lines(c(sales$X,newdata$X),c(model9$fitted.values,forecasts9),col='dodgerblue4',lwd=2)


