rm(list = ls())
library(e1071)
MD_SVM <- read.csv("CDK_MOR_sn_svm_H_selected for Prediction.csv")
MD_x <- data.matrix(MD_SVM[, 3:ncol(MD_SVM)])
MD_y <- MD_SVM$Y
svm_model <- svm(Y ~ ., data=MD_SVM,na.cation=na.omit)
summary(svm_model)

library(caret)
train_index <- createDataPartition(y=MD_SVM$Y, p=0.8, list=FALSE)
train <- MD_SVM[train_index,]
test <- MD_SVM[-train_index,]
train_matrix <- as.matrix(train[, 3:ncol(train)])
test_matrix <- as.matrix(test[, 3:ncol(test)])

gammas = 10^(-10:1)
costs = 2^(-3:10)
epsilons = c(0.1, 0.01, 0.001)
svmgs <- tune(svm,
              train.x =  as.matrix(train[, 3:ncol(train)]),
              train.y = as.matrix(train[, 2]),
              type = "eps-regression",
              kernel = "radial", 
              ranges = list(gamma = gammas, cost = costs, epsolon = epsilons),
              tunecontrol = tune.control(cross = 5),nfolds = 10
)

y1=train$Y
svrmodel <- svmgs$best.model
svrmodel

y1=train$Y
y_predicted <- predict(svrmodel, gamma = , cost = , epsolon = )
y_predicted