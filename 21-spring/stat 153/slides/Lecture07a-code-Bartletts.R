## Sample Autocorrelations of data from an MA(1) process:

# Simulate MA(1) data:
theta = -.8
n = 200
dt = arima.sim(n = n, list(ma = theta))

# Plot simulated data
plot(1:n, dt, type = "l", xlab = "Time", ylab = "Time Series", main = "MA(1)") 

#acf at lag one is given by
rho1 = theta/(1+theta^2)
acf(dt, plot = F)
acf(dt, lag.max = 20,  plot = T, main = "Sample Autocorrelation")

#variance of r1
w11 = 1-3*(rho1^2) + 4*(rho1^4)
w22 = 1+2*(rho1^2)
w12 = 2*rho1*(1-rho1^2)
c(w11, w22, w12)
vr1 = w11/n
vr2 = w22/n
r1r2cor = w12/(sqrt(w11*w22))
#Standard deviations of r1, r2 and their standard deviation under iid noise
c(sqrt(vr1), sqrt(vr2), 1/(sqrt(n)))

# blue lines for iid noise:
abline(h = 1.96/(sqrt(n)),col='blue',lwd=3,lty=3)
abline(h = -1.96/(sqrt(n)),col='blue',lwd=3,lty=3)

# red lines for MA(1), lags > 1
acf(dt, lag.max = 20,  plot = T, main = "Sample Autocorrelation", ylim=c(-1,1))

segments(x0=2,x1=20,y0=1.96*sqrt(vr2),col='red',lwd=3,lty=3)
segments(x0=2,x1=20,y0=-1.96*sqrt(vr2),col='red',lwd=3,lty=3)

points(1,rho1,col='red',cex=.5) 
points(1,rho1+1.96*sqrt(vr1),col=2,pch='-')
points(1,rho1-1.96*sqrt(vr1),col=2,pch='-')
# segments(1.1,rho1+1.96*sqrt(vr1),1.1,rho1-1.96*sqrt(vr1),col=2)

# segments(1.1,rho1+1.96*sqrt(vr1),1.1,rho1-1.96*sqrt(vr1),col=2)

