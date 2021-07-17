### Here I make up a time series
time = 1:100
X = time^2*10 + rnorm(100,0,400)
plot(time, X, type='l')


## First Differences
first.diffs = diff(X)
plot(first.diffs, type = "l", ylab = "First Differences", xlab = "Time")

## Second Differences
second.diffs = diff(first.diffs)
plot(second.diffs,type='l')
lines(diff(X,differences = 2),col='firebrick2')



### Now I look at the seasonal data: Turkey
Turkey.data = read.csv('~/Downloads/Turkey.csv')
time = 1:nrow(Turkey.data)
turkey = Turkey.data$Turkey
plot(time,turkey,type='l',lwd=2)

# if there were any doubt as to how many months to consider for the season lag, let's check the acf
acf(turkey) #major autocorrelation on 12th lag!
astsa::mvspec(turkey)
## Seasonal Differences
d = 12 # space between seasonal effects
seasonal.diffs = diff(turkey,lag = d)
plot(seasonal.diffs,type='l') #note change in the magnitude of the y-axis!
acf(seasonal.diffs) # much better, but not perfect. 
astsa::mvspec(seasonal.diffs)

# Seasonal differencing \nabla_d Y_t = Y_t - Y_{t-d}
seasonal.diffs = diff(turkey,lag = d)

# Higher order differencing: \nabla^2 Y_t = Y_t - 2Y_{t-1} + Y_{t-2}
diff(turkey,differences = 2)

# Higher order seasonal difference \nabla^2_d Y_t = Y_t - 2Y_{t-d} + Y_{t-2d}
diff(turkey,differences = 2,lag=d)


### Forecasting:
# Y_t+1 = Y_t + 
forecast = turkey[length(turkey)-11] + mean(diff(turkey,lag=12))
# this is just one point in the future. For further points, simply repeat the process on the time series that now includes your previous forecast. 
# We'll thoroughly discuss a function that does this for you, but it will be later this semester in conjunction with "SARIMA"
