#DSC440 Final project

rm(list=ls()) 
setwd('/Users/weihong/Desktop/data-science/UR/Data-Mining/ideology_predict')

library(ggplot2)
library(stargazer)
library(randomForest)
library(patchwork)
library(glmnet)
library(caret)


#read data
cfps <- read.csv('cfps_processed_short.csv')
ideology <- cfps[, 105:107]

#summary statistics
stargazer(ideology)

p_econ <- ggplot(ideology, aes(x=ideology_economic)) + geom_bar() + xlab('Economic ideology')
p_poli <- ggplot(ideology, aes(x=ideology_political)) + geom_bar() + xlab('Political ideology')
p_social <- ggplot(ideology, aes(x=ideology_social)) + geom_bar() + xlab('Social ideology')

p_econ + p_poli + p_social + plot_layout(ncol = 2)


#linear regressions
cols1 <- c(3:105)
cols2 <- c(3:104, 106)
cols3 <- c(3:104, 107)

fit1 <- lm(ideology_economic ~., data = cfps[,cols1])
fit2 <- lm(ideology_political ~., data = cfps[,cols2])
fit3 <- lm(ideology_social ~., data = cfps[,cols3])

#summary(fit2)
#mean(fit2$residuals^2)
#mean(fit1$residuals^2)

stargazer(fit1, fit2, fit3, title="Results", align=TRUE)

#LASSO regression model
## economic ideology
lasso1 <- cfps[!is.na(cfps$ideology_economic),]
c1 <- c(3:104)
x1 <- lasso1[,c1]
y1 <- lasso1$ideology_economic

lasso_reg1 <- cv.glmnet(data.matrix(x1), y1, alpha = 1)
lambda_best1 <- lasso_reg1$lambda.min
lasso_model1 <- glmnet(data.matrix(x1), y1, alpha = 1, lambda = lambda_best1)
coef(lasso_model1)

#i <- which(lasso_reg1$lambda == lasso_reg1$lambda.min)
#mse.min <- lasso_reg1$cvm[i]

## political ideology
lasso2 <- cfps[!is.na(cfps$ideology_political),]
c2 <- c(3:104)
x2 <- lasso2[,c2]
y2 <- lasso2$ideology_political

lasso_reg2 <- cv.glmnet(data.matrix(x2), y2, alpha=1)
lambda_best2 <- lasso_reg2$lambda.min
lasso_model2 <- glmnet(data.matrix(x2), y2, alpha = 1, lambda = lambda_best2)
coef(lasso_model2)

## social ideology
lasso3 <- cfps[!is.na(cfps$ideology_social),]
c3 <- c(3:104)
x3 <- lasso3[,c3]
y3 <- lasso3$ideology_social

lasso_reg3 <- cv.glmnet(data.matrix(x3), y3, alpha=1)
lambda_best3 <- lasso_reg3$lambda.min
lasso_model3 <- glmnet(data.matrix(x3), y3, alpha = 1, lambda = lambda_best3)
coef(lasso_model3)

# Random forest model
## economic ideology
r1 <- c(3:105)
rf1 <- cfps[, r1]
rf1 <- rf1[complete.cases(rf1), ]
randomF_econ<- randomForest(x = rf1[, 1:ncol(rf1)-1],
                         y = rf1[, ncol(rf1)],
                         ntree = 100)
print(randomF_econ)
varImpPlot(randomF_econ)

## political ideology
r2 <- c(3:104, 106)
rf2 <- cfps[, r2]
rf2 <- rf2[complete.cases(rf2), ]
randomF_politics<- randomForest(x = rf2[, 1:ncol(rf2)-1],
                        y = rf2[, ncol(rf2)],
                        ntree = 100)
print(randomF_politics)
varImpPlot(randomF_politics)

## social ideology
r3 <- c(3:104, 107)
rf3 <- cfps[, r3]
rf3 <- rf3[complete.cases(rf3), ]
randomF_social<- randomForest(x = rf3[, 1:ncol(rf3)-1],
                        y = rf3[, ncol(rf3)],
                        ntree = 100)

print(randomF_social)
varImpPlot(randomF_social)

# Cross-validation
#OLS
## economic ideology
train.control <- trainControl(method = "cv", number = 10)
cv_cfps1 <- cfps[,cols1]
cv_cfps1 <- cv_cfps1[complete.cases(cv_cfps1), ]
cv_ols1 <- train(ideology_economic ~., data = cv_cfps1, method = "lm",
               trControl = train.control)
print(cv_ols1)

system.time(fit1 <- lm(ideology_economic ~., data = cfps[,cols1]))

## political ideology
cv_cfps2 <- cfps[,cols2]
cv_cfps2 <- cv_cfps2[complete.cases(cv_cfps2), ]
cv_ols2 <- train(ideology_political ~., data = cv_cfps2, method = "lm",
                 trControl = train.control)
print(cv_ols2)
system.time(fit2 <- lm(ideology_political ~., data = cfps[,cols2]))

## social ideology
cv_cfps3 <- cfps[,cols3]
cv_cfps3 <- cv_cfps3[complete.cases(cv_cfps3), ]
cv_ols3 <- train(ideology_social ~., data = cv_cfps3, method = "lm",
                 trControl = train.control)
print(cv_ols3)
system.time(fit3 <- lm(ideology_social ~., data = cfps[,cols3]))

#LASSO regression
## economic ideology
mse1 <- cv.glmnet(data.matrix(x1), y1, type.measure = "mse", nfolds = 10)
print(mse1)
system.time(lasso_model1 <- glmnet(data.matrix(x1), y1, alpha = 1, lambda = lambda_best1))


## political ideology
mse2 <- cv.glmnet(data.matrix(x2), y2, type.measure = "mse", nfolds = 10)
print(mse2)
system.time(lasso_model2 <- glmnet(data.matrix(x2), y2, alpha = 1, lambda = lambda_best2))

## social ideology
mse3 <- cv.glmnet(data.matrix(x3), y3, type.measure = "mse", nfolds = 10)
print(mse3)
system.time(lasso_model3 <- glmnet(data.matrix(x3), y3, alpha = 1, lambda = lambda_best3))

# Random forest
system.time(randomF_econ<- randomForest(x = rf1[, 1:ncol(rf1)-1],
                                        y = rf1[, ncol(rf1)],
                                        ntree = 100))

system.time(randomF_politics<- randomForest(x = rf2[, 1:ncol(rf2)-1],
                                            y = rf2[, ncol(rf2)],
                                            ntree = 100))

system.time(randomF_social<- randomForest(x = rf3[, 1:ncol(rf3)-1],
                                          y = rf3[, ncol(rf3)],
                                          ntree = 100))
