Lab 4--MATH 243
================
Theodore Dounias
October 3, 2017

**1**

``` r
war <- war %>%
  mutate(exports_quad = exports^2)

cw_logit <- glm(start ~ exports + schooling + growth + peace + concentration + lnpop + fractionalization + dominance + exports_quad, family = binomial, data = war)

summary(cw_logit)
```

    ## 
    ## Call:
    ## glm(formula = start ~ exports + schooling + growth + peace + 
    ##     concentration + lnpop + fractionalization + dominance + exports_quad, 
    ##     family = binomial, data = war)
    ## 
    ## Deviance Residuals: 
    ##     Min       1Q   Median       3Q      Max  
    ## -1.3655  -0.3627  -0.1893  -0.0932   3.3636  
    ## 
    ## Coefficients:
    ##                     Estimate Std. Error z value Pr(>|z|)    
    ## (Intercept)       -1.307e+01  2.795e+00  -4.677 2.91e-06 ***
    ## exports            1.894e+01  5.865e+00   3.229 0.001243 ** 
    ## schooling         -3.156e-02  9.784e-03  -3.225 0.001259 ** 
    ## growth            -1.152e-01  4.307e-02  -2.675 0.007466 ** 
    ## peace             -3.713e-03  1.093e-03  -3.397 0.000681 ***
    ## concentration     -2.487e+00  1.005e+00  -2.474 0.013357 *  
    ## lnpop              7.677e-01  1.658e-01   4.632 3.63e-06 ***
    ## fractionalization -2.135e-04  9.102e-05  -2.345 0.019020 *  
    ## dominance          6.704e-01  3.535e-01   1.896 0.057920 .  
    ## exports_quad      -2.944e+01  1.178e+01  -2.499 0.012449 *  
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## (Dispersion parameter for binomial family taken to be 1)
    ## 
    ##     Null deviance: 337.73  on 687  degrees of freedom
    ## Residual deviance: 256.42  on 678  degrees of freedom
    ##   (600 observations deleted due to missingness)
    ## AIC: 276.42
    ## 
    ## Number of Fisher Scoring iterations: 7

All predictors apart from dominance are statistically significant at the 5% level.

**2**

``` r
#1

cw_logit <- glm(start ~ exports + schooling + growth + peace + concentration + lnpop + fractionalization + exports_quad, family = binomial, data = war)

ind_1975 <- war %>%
  filter(country == "India", year == "1975") %>%
  select(-(1:3))

predict(cw_logit, type = "response", ind_1975)
```

    ##         1 
    ## 0.3752647

``` r
ind_1975[2] <- ind_1975[2] + 30

predict(cw_logit, type = "response", ind_1975)
```

    ##        1 
    ## 0.201406

``` r
ind_1975 <- war %>%
  filter(country == "India", year == "1975") %>%
  select(-(1:3))

ind_1975[1] <- ind_1975[1] + 0.1

predict(cw_logit, type = "response", ind_1975)
```

    ##         1 
    ## 0.7850989

``` r
#2

nig_1965 <- war %>%
  filter(country == "Nigeria", year == "1965") %>%
  select(-(1:3))

predict(cw_logit, type = "response", nig_1965)
```

    ##         1 
    ## 0.1864533

``` r
nig_1965[2] <- nig_1965[2] + 30

predict(cw_logit, type = "response", nig_1965)
```

    ##          1 
    ## 0.08777933

``` r
nig_1965 <- war %>%
  filter(country == "Nigeria", year == "1965") %>%
  select(-(1:3))

nig_1965[1] <- nig_1965[1] + 0.1

predict(cw_logit, type = "response", nig_1965)
```

    ##         1 
    ## 0.5822716

The difference in probabilities is not the same because we are dealing with log odds, not with a linear association. Therefore a change in a variable will not have the same effect ranging between two different observations. The function for getting a probability here is dependant on both the relative difference--here what we add to the observed values--and the prior state of the values of the observations.

**3**

``` r
#1
my_log_pred <- ifelse(cw_logit$fit < 0.5, "No", "Yes")
Civ_war <- mutate(na.omit(war), civ_war_Yes = ifelse(start == 1, "Yes", "No"))

conf_log <- table(my_log_pred, Civ_war$civ_war_Yes)
conf_log
```

    ##            
    ## my_log_pred  No Yes
    ##         No  638  43
    ##         Yes   4   3

``` r
#2
(1/nrow(Civ_war)) * (conf_log[2, 1] + conf_log[1, 2])
```

    ## [1] 0.06831395

``` r
#3
count <- war %>%
  filter(!is.na(start)) %>%
  summarize(n_start = sum(start))

(1/sum(!is.na(start)))*count[1, 1]
```

    ## [1] 0.06683805

``` r
(1/nrow(Civ_war))*sum(Civ_war$civ_war_Yes == "Yes")
```

    ## [1] 0.06686047
