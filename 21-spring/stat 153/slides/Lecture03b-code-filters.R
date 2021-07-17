library(astsa)
sales = read.csv('sales.csv')
plot.ts(sales$sales)

# Exponential Smoothing
a = .99
weights =  (a^(1:20)) # could also multiply by (1-a)/a, but we'll normalize below. 
weights = weights/sum(weights) #make weights sum to one. Is that the right choice?
weights = c(0,weights) # add a 0 to the front, so that Yt gets no weight when forecasting Yt. Only uses past data

m = filter(sales$sales,sides = 1,filter=weights)
lines(m,col=2,lwd=3)

# equal weight moving average/Rolling window/q-step smoothing
q = 20
w = rep(1/(2*q+1),2*q+1)
m2 = filter(sales$sales,filter=w,sides=2)
lines(m2,col=4,lwd=3)

# Get creative? What if we use the data from one week and one year ago? 
weights = rep(0,365)
weights[7] = 1/2
weights[365] = 1/2 *1.05 #arbitrary choice? We'll see how to pursue this idea (albeit a bit different) next time!
weights = c(0,weights)
m3 = filter(sales$sales,filter=weights,sides=1)
lines(m3,col=3,lwd=2)

# Zoom in
plot.ts(sales$sales,xlim=c(1100,nrow(sales)))
lines(m3,col=3,lwd=2)
