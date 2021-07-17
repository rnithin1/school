data("JohnsonJohnson")
jj = JohnsonJohnson
plot.ts(jj)
n = length(jj)

# Simple approach with Deterministic function
time = 1:n
Quarters = as.character(time%%4)
model1 = lm(jj ~ time + I(time^2) + Quarters)
plot(time,jj,type='l')
lines(time,model1$fitted.values,col='hotpink',lwd=3)
# Residual plot: how did we do?
plot(model1$residuals,type='l')

# our first complicated approach: interaction of trend and seasonality. 
complicated = lm(jj ~ time*Quarters + I(time^2)*Quarters)
plot(time,jj,type='l')
lines(time,complicated$fitted.values,col='seagreen2',lwd=3)
# Residual plot: how did we do?
plot(complicated$residuals,type='l')
# This model has 12 terms and still doesn't pass the "shoebox" test. Time to look elsewhere?


# Yearly difference (\nabla_4)
plot.ts(diff(jj,lag=4,differences = 2)) 
# still has heteroskedasticity


####
#### Now we'll try some of our more recent approaches
####

# Log of Y?
logmodel = lm(log(jj) ~ time + I(time^2) + Quarters)
plot(time,log(jj), type='l')
lines(time,logmodel$fitted.values,col='hotpink',lwd=3)
#
plot.ts(logmodel$residuals)


# Percent changes? !quarterly data!
quarterly_percent_change = (jj[2:n] - jj[1:(n-1)])/jj[1:(n-1)]
plot.ts(quarterly_percent_change)
# the same: diff(jj)/jj[1:(n-1)]



# Yearly percent change:
annual_percent_change = diff(jj,lag=4)/jj[1:(n-4)]
plot.ts(annual_percent_change)
# not bad!


