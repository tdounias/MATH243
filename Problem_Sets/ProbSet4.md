Problem Set 4 --MATH 243
================
Theodore Dounias
September 29, 2017

#### Exercises 4, 6, 7: ISLR

**4**

1.  We use 1/10th of the observations, since we use those in a .10 range out of a uniformy distribution from 0 to 1.

2.  In this case we use 1/100th of the observations, since we use 1/10th of X1 crossed with 1/10th of X2.

3.  We use 1/(10^100)th of the available observations

4.  We see here that the number of observations we actually use with KNN, while keeping the range from which we accept influence from observations (ie the K-value) steady, decreases exponentially. Therefore, we are essentially not using the full range of possibilities that having a large amount of predictors and data offers to the modeling process.

5.  For p = 1, it is 1/10th of the range of the predictor. For p = 2, it is 1/(sqrt(10)) = 1/(10^(1/2)). For p = 100, it would be 1/(10^(1/100)). In this scenario we would always have 1/10th of the observations.

**6**

1.  We have:

``` r
b0 <- -6
b1 <- 0.05
b2 <- 1

pX <- function(b0, b1, b2, x1, x2) {
  (exp(b0 + b1*x1 + b2*x2))/(1 + (exp(b0 + b1*x1 + b2*x2)))
}

pX(b0, b1, b2, 40, 3.5)
```

    ## [1] 0.3775407

1.  

``` r
v <- 0
for(i in 40:60){
  if(pX(b0, b1, b2, i, 3.5) >= .5) {
    v <- i
    break
  }
}
v
```

    ## [1] 50

**7**

``` r
sigma <- 6
mean_div <- 10
mean_no_div <- 0

pdf <- function(x, m){
  (1/(sigma*sqrt(2*pi)))*exp(-(1/(2*sigma^2))*(x - m^2))
}


prob_div <- function(x){
  (pdf(x, mean_div)*.8)/((pdf(x, mean_div)*.8) + (pdf(x, mean_no_div)*.2))
}

prob_div(4)
```

    ## [1] 0.9413199
