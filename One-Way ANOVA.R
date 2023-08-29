# ONE-WAY ANOVA

## **LOAD LIBRARIES**

```{r}
# For everything that is good in R
library(tidyverse)

# To get useful summary statistics
library(summarytools)

# To visualize data
library(ggpubr)

# To compute estimated marginal means
library(emmeans)

# To write automated statistical reports
library(report)
```

## **ATTACH DATA**

```{r}
# Store the Tooth Growth dataset
df <- datasets::ToothGrowth

# Get the structure of the dataset
str(df)

# Convert `dose` which has been recognized as numeric to a factor
df$dose <- as.factor(df$dose)

# Attach the dataframe to enable easy calling of variables
attach(df)

# Get the first 6 rows of the dataframe
head(df)

# Get the last 6 rows of the dataframe
tail(df)

# Get more information for the dataset
?ToothGrowth
```

## **SUMMARY STATISTICS**

```{r}
# Use the `dfSummary` function 
summ <- df %>% group_by(dose) %>% dfSummary()
```

## **ANOVA ASSUMPTIONS**

1.  Independence: The observations in each group are independent of each other and the observations within groups are obtained by random sampling.

2.  Normality: Each sample was drawn from a normally distributed population.

    ```{r}
    # Runs the Shapiro-Wilk test for normality
    shapiro.test(len[dose==0.5])
    shapiro.test(len[dose==1])
    shapiro.test(len[dose==2])
    ```

3.  Homogeneity of variances: The variances of the populations that the samples come from are equal.

    ```{r}
    # Runs the Bartlett test for homogeneity of variances
    bartlett.test(len ~ dose)
    ```

## **ANALYSIS OF VARIANCE**

```{r}
# Run our one-way analysis of variance and store results in `fit`
fit <- aov(len ~ dose)

# Automate statistical reporting of the ANOVA
report(fit)

# Store the estimated marginal means in an object
em <- emmeans(fit, pairwise ~ dose)

# Get results for the estimated marginal means
summary(em)

# Get confidence intervals for pairwise EMM differences
confint(em)

# Plot EMMs
plot(em)
```

## PLOTS

```{r}
# Plot means with confidence intervals
ggline(data = df,
       x = "dose",
       y = "len",
       add = "mean_ci",
       size = 1)

# Plot boxplots
ggboxplot(data = df,
          x = "dose",
          y = "len")
```
