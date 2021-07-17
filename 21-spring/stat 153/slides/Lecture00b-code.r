library(astsa)
plot(Hare)


Gaussian.Noise = rnorm(100)
plot.ts(Gaussian.Noise)
plot(Gaussian.Noise,type='l',xlab="Time",lwd=3)

acf(Gaussian.Noise, lag.max = 50)

time = 1:length(Gaussian.Noise)
lm(Gaussian.Noise ~ time)

j = 0
# For Loop
for(i in 1:1000){
  j = j + 1
}

# Vectors
# 5th element of a vector
Gaussian.Noise[5]

# elements 5 through 98
Gaussian.Noise[5:98]

