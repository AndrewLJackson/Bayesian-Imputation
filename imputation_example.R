# This example code taken from stats.stackexchange on 30/3/15
# http://stats.stackexchange.com/questions/99185/simultaneous-imputation-of-multiple-binary-variables-in-r

# just make results reproducible: 

set.seed(123)
# create correlated random binary (0/1) variables
x1 <- runif(100,0,1)          # N(0,1))
x2 <- x1 * runif(100,0,1)     # N(0,1))
x3 <- x2 * runif(100,0,1)+0.2 # N(0,1))
x1 <- round(x1)
x2 <- round(x2)
x3 <- round(x3)

df1 <- as.data.frame(cbind(x1,x2,x3))

cor(df1)



#introduce random missing (MCAR)
x1[seq(1,100,7)]<-NA
x2[seq(2,100,7)]<-NA
x3[seq(3,100,7)]<-NA
df <- as.data.frame(cbind(x1,x2,x3))
plot
# need to create a factor 
df$x1 <- as.factor (df$x1)
df$x2 <- as.factor (df$x2)
df$x3 <- as.factor (df$x3)

require(mice)
imp <- mice(df, seed = 1233, method = "logreg") 
# logistic regression for binary variable 
#Generates multiple imputations for incomplete multivariate data by Gibbs sampling

complete.df <- complete(imp)

mdf <- data.matrix(complete.df) # convert to numeric matrix for correlation calculation 

cor(mdf)
