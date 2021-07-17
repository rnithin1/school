turkey = read.csv("~/Downloads/Turkey.csv")


pgram = function(x){
  m = floor(length(x)/2)
  pgram = abs(fft(x)[2:(m+1)])^2/length(x)
  plot(pgram, type = "h")
  abline(h=0)
  return(pgram)
}

pgram(turkey$Turkey)
points(16,5393,col=2)


#Sinusoids with frequencies of the form (j/n) are easy to guess 
#(here n is the data size and j is an integer). 
#These frequencies are called Fourier frequencies. 

#Data from two sinusoids at Fourier Frequencies
n = 100
tme = 0:(n-1)
f1 = 0.05
f2 = 0.1
x = 10*sin(2*pi*f1*tme) + 3*cos(2*pi*f1*tme) + 5*cos(2*pi*f2*tme)
plot(tme, x, type = "o")

pgram(x)

#Data from five sinusoids at Fourier frequencies
n = 100
tme = 0:(n-1)
f1 = 0.25
f2 = 0.1
f3 = 0.33
f4 = 0.01
f5 = 0.15
x = 10*sin(2*pi*f1*tme) + 3*cos(2*pi*f1*tme) + 5*cos(2*pi*f2*tme) + 8*sin(2*pi*f3*tme) + 4*cos(2*pi*f4*tme) + 7*sin(2*pi*f5*tme) + 3*cos(2*pi*f5*tme)
plot(tme, x, type = "o")

pgram(x)

#Back to the two sinusoid example: 
n = 100
tme = 0:(n-1)
f1 = 0.05
f2 = 0.1
x = 10*sin(2*pi*f1*tme) + 3*cos(2*pi*f1*tme) + 5*cos(2*pi*f2*tme)
plot(tme, x, type = "o")
pgram(x)
#Looking at x, we can figure out the frequencies present in the data 
#by just using linear regression: 
#Start with a candidate fourier frequency f
#Regress the data on cos(2*pi*f*tme) and sin(2*pi*f*tme)
#For example, suppose f = 0.01
f = 0.01
summary(lm(x ~ cos(2*pi*f*tme) + sin(2*pi*f*tme)))
#Observe that this regression gives nothing 
#(i.e., the linear model estimated coefficients are all zero upto rounding errors). 
#This means that this Fourier frequency f = 0.01 is not present in the data. 
#Let us repeat this with another Fourier frequency
f = 0.02
summary(lm(x ~ cos(2*pi*f*tme) + sin(2*pi*f*tme)))
#Same story again. 
#Now suppose that f = 0.05. 
#This frequency is actually present in the data. 
f = 0.05
summary(lm(x ~ cos(2*pi*f*tme) + sin(2*pi*f*tme)))
#Now the estimated regression coefficients are non-zero 
#and they equal exactly the coefficients used to generate the data. 
#This is the basic idea behind the Discrete Fourier Transform. 


#Understanding the DFT
n = 11
x = rnorm(n)
fft(x)
pgram = abs(fft(x)[2:6])^2/n
plot(pgram, type = "h")

n = 10
x = rnorm(n)
fft(x)
pgram = abs(fft(x)[2:6])^2/n
plot(pgram, type = "h")

#Larger n
n = 100
tme = 0:(n-1)
f = .5/n
x = 10*sin(2*pi*f*tme) + 3*cos(2*pi*f*tme)
plot(tme, x, type = "o") + rnorm(n)
plot(1:50, abs(fft(x)[2:51])^2/n, type = "h", ylab = "Periodogram")
abline(h = 0)

n = 100
tme = 0:(n-1)
f = 6/n
x = 10*sin(2*pi*f*tme) + 3*cos(2*pi*f*tme)
plot(tme, x, type = "o")
plot(1:50, abs(fft(x)[2:51])^2/n, type = "h", ylab = "Periodogram")
abline(h = 0)


#Two Frequencies
n = 100
tme = 0:(n-1)
f1 = 0.25
f2 = 0.1
x = 10*sin(2*pi*f1*tme) + 3*cos(2*pi*f1*tme) + 5*cos(2*pi*f2*tme) + rnorm(n,0,.001)
plot(tme, x, type = "o")
plot(1:50, abs(fft(x)[2:51])^2/n, type = "h", ylab = "Periodogram")
abline(h = 0)
#Once frequencies are figured out, one can do a linear regression to figure out amplitudes 
#and phases. 
x1 = cos(2*pi*f1*tme)
x2 = sin(2*pi*f1*tme)
x3 = cos(2*pi*f2*tme)
x4 = sin(2*pi*f2*tme)
reg = lm(x ~ 1 + x1 + x2 + x3 + x4)
summary(reg)


#Five Frequencies
n = 100
tme = 0:(n-1)
f1 = 0.25
f2 = 0.1
f3 = 0.33
f4 = 0.01
f5 = 0.15
x = 10*sin(2*pi*f1*tme) + 3*cos(2*pi*f1*tme) + 5*cos(2*pi*f2*tme) + 8*sin(2*pi*f3*tme) + 4*cos(2*pi*f4*tme) + 7*sin(2*pi*f5*tme) + 3*cos(2*pi*f5*tme)
plot(tme, x, type = "o")
plot(1:50, abs(fft(x)[2:51])^2/n, type = "h", ylab = "Periodogram")
abline(h = 0)

###Leakage
n = 100
tme = 0:(n-1)
f = 0.062
x = 10*sin(2*pi*f*tme) + 3*cos(2*pi*f*tme)
plot(tme, x, type = "o")
plot(1:50, (abs(fft(x)[2:51])^2/n), type = "h", ylab = "Periodogram")
abline(h = 0)


n = 100
tme = 0:(n-1)
f = 0.065
x = 10*sin(2*pi*f*tme) + 3*cos(2*pi*f*tme)
plot(tme, x, type = "o")
#
plot(1:50, abs(fft(x)[2:51])^2/n, type = "h", ylab = "Periodogram")
abline(h = 0)

n = 1000
tme = 0:(n-1)
f = 0.065
x = 10*sin(2*pi*f*tme) + 3*cos(2*pi*f*tme)
plot(tme, x, type = "o")
plot(1:500, abs(fft(x)[2:501])^2/n, type = "h", ylab = "Periodogram")
abline(h = 0)


#Leakage again
n = 100
tme = 0:(n-1)
f1 = 0.253
f2 = 0.10
x = 10*sin(2*pi*f1*tme) + 3*cos(2*pi*f1*tme) + 5*cos(2*pi*f2*tme)
plot(tme, x, type = "o")
plot(1:50, abs(fft(x)[2:51])^2/n, type = "h", ylab = 'Periodogram')
abline(h = 0)

#White Noise
x = rnorm(100)
plot(x, type = "o", main = "White Noise")
plot(1:50, abs(fft(x)[2:51])^2/n, type = "h", ylab = "Periodogram")
abline(h = 0)

#Structure + White Noise
n = 100
tme = 0:(n-1)
f1 = 0.25
f2 = 0.1
x = 10*sin(2*pi*f1*tme) + 3*cos(2*pi*f1*tme) + 5*cos(2*pi*f2*tme)
x = x + rnorm(n)
plot(tme, x, type = "o")
plot(1:50, abs(fft(x)[2:51])^2/n, ylab = "Periodogram", type = "h")
abline(h = 0)


#Increase Noise Level
n = 100
tme = 0:(n-1)
f1 = 0.25
f2 = 0.1
x = 10*sin(2*pi*f1*tme) + 3*cos(2*pi*f1*tme) + 5*cos(2*pi*f2*tme)
x = x + 4*rnorm(n)
plot(tme, x, type = "o")
plot(1:50, (abs(fft(x)[2:51])^2/n), type = "h", ylab = "Periodogram")
abline(h = 0)

#Increase Noise Even More
n = 100
tme = 0:(n-1)
f1 = 0.25
f2 = 0.1
x = 10*sin(2*pi*f1*tme) + 3*cos(2*pi*f1*tme) + 5*cos(2*pi*f2*tme)
x = x + 16*rnorm(n)
plot(tme, x, type = "o")
plot(1:50, (abs(fft(x)[2:51])^2/n), type = "h", ylab = "Periodogram")
abline(h = 0)



### Why n/2 limit on j? in other words, max freq of interest is 1/2
n = 40
tme = 0:(n-1)
f1 = 0.65
x = cos(2*pi*f1*tme)
plot(tme, x, type = "o")
f2 = 1 - f1
y = cos(2*pi*f2*tme)
lines(tme,y,col=2,type='o',pch=2,lty=2)
## What happened!?! they're not the same sinusoid. 

# The curve function can plot the curve itself, not just the discretely sampled points! 
# only looking at t=0,...,20 here
curve(cos(2*pi*f1*x),0,20,n=1000,xlab='t')
curve(cos(2*pi*f2*x),0,20,n=1000,add=T,col=2)
points(tme,x)
# Note that the sinusoids create the same points when discretely observing at uniform intervals on integers

## And check out their periodograms:
# x
plot(1:floor(n/2), (abs(fft(x)[2:(floor(n/2)+1)])^2/n), type = "h", ylab = "Periodogram")
abline(h = 0)
# y
plot(1:floor(n/2), (abs(fft(x)[2:(floor(n/2)+1)])^2/n), type = "h", ylab = "Periodogram")
abline(h = 0)


### Built-in periodogram functions
# You may need to install some packages

# the double colon :: uses a function from a package without needing to load that function's whole library/package. 
# note the x axis for this one is in frequency (j/n), not j 
TSA::periodogram(x)

# This is a "smoothed" periodogram, an estimate of the "spectral density" 
# We'll dive into the spectral density at the end of the course
astsa::mvspec(x) 
