turkey = read.csv("~/Downloads/Turkey.csv")
plot.ts(turkey$Turkey)

head(turkey)
summary(turkey)
time = 1:nrow(turkey)#seq(2004+0/12,2019+8/12,by=1/12)
plot(time,turkey$Turkey,type='l')

## Parametric fit
d = 12
cos1 = cos(2*pi*time*1/d); sin1 = sin(2*pi*time*1/d)
cos2 = cos(2*pi*time*2/d); sin2 = sin(2*pi*time*2/d)
cos3 = cos(2*pi*time*3/d); sin3 = sin(2*pi*time*3/d)
cos4 = cos(2*pi*time*4/d); sin4 = sin(2*pi*time*4/d)
cos5 = cos(2*pi*time*5/d); sin5 = sin(2*pi*time*5/d)
cos6 = cos(2*pi*time*6/d); sin6 = sin(2*pi*time*6/d)

model_s_p = lm(turkey$Turkey ~ cos1 + cos2 + cos3 + cos4 + cos5 + cos6 + sin1 + sin2 + sin3 + sin4 + sin5 + sin6)

lines(time,model_s_p$fitted.values,lwd=3,col="green")

## Add the trend

model_ms_p = lm(turkey$Turkey ~ time + cos1 + cos2 + cos3 + cos4 + cos5 + cos6 + sin1 + sin2 + sin3 + sin4 + sin5 + sin6)
plot(time,turkey$Turkey,type='l')
lines(time,model_ms_p$fitted.values,lwd=6,col="dodgerblue")
lines(time,model_s_p$fitted.values,lwd=2,col="firebrick4")

### "Nonparametric" model 
# seasonality only
model_s_n = lm(turkey$Turkey ~ turkey$month)
plot(time,turkey$Turkey,type='l')
lines(time,model_s_n$fitted.values,lwd=3,col="red")
# Note that the fitted values are the same as the parametric version
# but we see there's a trend

# Add the trend
model_ms_n = lm(turkey$Turkey ~ time + turkey$month)
plot(time,turkey$Turkey,type='l')
lines(time,model_ms_n$fitted.values,lwd=3,col="red")
# But we seet that the trend is different for November compared to the other months. 

# The asterisk in R's formula below creates an "interaction", where all possible combinations of time (continuous variable) and month (categorical variable) are created. 
# This essentially creates a slope and intercept for each month
model_ms_n2 = lm(turkey$Turkey ~ time * turkey$month)
plot(time,turkey$Turkey,type='o')
lines(time,model_ms_n2$fitted.values,lwd=3,col="red")

###
### Sinusoids
###

g = function(t,R,f,Phi){
  R*cos(2*pi*f*t + Phi)
} 
# We can play with the values here to see what R,f,and Phi do
curve(g(x,R=2,f=1/2,Phi=.5),from=0,to=5, n=1000)

# Note that as we add sinusoids together, we create more complicated phenomenon
curve(g(x,R=1,f=1/2,Phi=0)+g(x,R=4,f=.3,Phi=1)+g(x,R=2,f=2,Phi=0),from=0,to=10, n=1000)


