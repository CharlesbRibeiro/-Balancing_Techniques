library(tidyverse)
library(sqldf)
library(corrplot)
library(caret)
library(caTools)
library(Rtsne)
library(ROSE)
library(rpart)
library(Rborist)
library(xgboost)

install.packages('SMOTE')






data_base <- read.csv(file = 'creditcard.csv',header = T,sep = ",")


#Verificando se a base de dados apresenta valores Null

is.null(data_base)

colSums(is.na(data_base))

#Verificando o desbalanceamento fraudes

sqldf('select class,count(*) * 100.0 / (select count (*) from data) from data group by class;')


table(data_base$Class)

prop.table(table(data_base$Class))

fig(12, 8)
common_theme <- theme(plot.title = element_text(hjust = 0.5, face = "bold"))

ggplot(data = data_base, aes(x = factor(Class), 
                      y = prop.table(stat(count)), fill = factor(Class),
                      label = scales::percent(prop.table(stat(count))))) +
  geom_bar(position = "dodge") + 
  geom_text(stat = 'count',
            position = position_dodge(.9), 
            vjust = -0.5, 
            size = 3) + 
  scale_x_discrete(labels = c("no fraud", "fraud"))+
  scale_y_continuous(labels = scales::percent)+
  labs(x = 'Class', y = 'Percentage') +
  ggtitle("Distribution of class labels") +
  common_theme

#Verificando a distribuição

data_base %>%
  ggplot(aes(x = Time, fill = factor(Class))) + geom_histogram(bins = 100)+
  labs(x = 'Time in seconds since first transaction', y = 'No. of transactions') +
  ggtitle('Distribution of time of transaction by class') +
  facet_grid(Class ~ ., scales = 'free_y') + common_theme

ggplot(data_base, aes(x = factor(Class), y = Amount)) + geom_boxplot() + 
  labs(x = 'Class', y = 'Amount') +
  ggtitle("Distribution of transaction amount by class") + common_theme


#Verificando a correlação dos dados

corre <- cor(data_base[,-1],method="pearson")

corrplot(corre,method = 'number')

#visualizando as transações usando t-SNE

# Use 10% of data to compute t-SNE

tsne_subset <- 1:as.integer(0.1*nrow(data_base))

tsne <- Rtsne(data_base[tsne_subset,-c(1, 31)], 
              perplexity = 20, 
              theta = 0.5, pca = F, 
              verbose = F, 
              max_iter = 500, 
              check_duplicates = F)

classes <- as.factor(data_base$Class[tsne_subset])

tsne_mat <- as.data.frame(tsne$Y)

ggplot(tsne_mat, aes(x = V1, y = V2)) + geom_point(aes(color = classes)) + theme_minimal() + common_theme + ggtitle("t-SNE visualisation of transactions") + scale_color_manual(values = c("#E69F00", "#56B4E9"))


#Data preparation

df <- data_base[,-1]

df$Class <- as.factor(df$Class)
levels(df$Class) <- c("N-fraud","Fraud")

df[,-30] <- scale(df[,-30])

#dividindo os dados em treinamento e teste

set.seed(123)

split <- sample.split(df$Class, SplitRatio = 0.7)
train <-  subset(df, split == TRUE)
test <- subset(df, split == FALSE)

table(train$Class)

# under_sampling or downsampling (ou sub_amostra)

set.seed(9560)

down_train <- downSample(x = train[, -ncol(train)],
                         y = train$Class)
table(down_train$Class)

# upsampling or oversampling (ou sob amostra)

set.seed(9560)
up_train <- upSample(x = train[, -ncol(train)],
                     y = train$Class)
table(up_train$Class)

#artificial data SMOTE AND ROSE (dados artificiais Smote e Rose)

#SMOTE
set.seed(9560)

smote_train <- SMOTE(Class ~ ., data  = train)

smote_train <- 

table(smote_train$Class)

#Rose
set.seed(9560)
rose_train <- ROSE(Class ~ ., data  = train)$data 

table(rose_train$Class)

#CART Model Performance on imbalanced data

set.seed(5627)

orig_fit <- rpart(Class ~ ., data = train)

#Evaluate model performance on test set
pred_orig <- predict(orig_fit, newdata = test, method = "class")

roc.curve(test$Class, pred_orig[,2], plotit = TRUE)


# Decision Tree on various sampling techniques (Arvore de decisao em varias tecnicas de amostragem)

set.seed(5627)

# Build down-sampled model


down_fit <- rpart(Class ~ ., data = down_train)


set.seed(5627)
# Build up-sampled model


up_fit <- rpart(Class ~ ., data = up_train)


set.seed(5627)
# Build smote model


smote_fit <- rpart(Class ~ ., data = smote_train)

set.seed(5627)
# Build rose model


rose_fit <- rpart(Class ~ ., data = rose_train)
# AUC on down-sampled data
pred_down <- predict(down_fit, newdata = test)

print('Fitting model to downsampled data')
roc.curve(test$Class, pred_down[,2], plotit = FALSE)

# AUC on up-sampled data
pred_up <- predict(up_fit, newdata = test)

print('Fitting model to upsampled data')
roc.curve(test$Class, pred_up[,2], plotit = FALSE)

# AUC on up-sampled data
pred_smote <- predict(smote_fit, newdata = test)

print('Fitting model to smote data')
roc.curve(test$Class, pred_smote[,2], plotit = FALSE)

# AUC on up-sampled data
pred_rose <- predict(rose_fit, newdata = test)

print('Fitting model to rose data')
roc.curve(test$Class, pred_rose[,2], plotit = FALSE)


#Utilizando varios modelos com (up-sampled) para visualizar que obtem melhor resultado

#logistic regression

glm_fit <- glm(Class ~ ., data = up_train, family = 'binomial')

pred_glm <- predict(glm_fit, newdata = test, type = 'response')

roc.curve(test$Class, pred_glm, plotit = TRUE)


#Random Forest 

x = up_train[, -30]
y = up_train[,30]

rf_fit <- Rborist(x, y, ntree = 1000, minNode = 20, maxLeaf = 13)


rf_pred <- predict(rf_fit, test[,-30], ctgCensus = "prob")
prob <- rf_pred$prob

roc.curve(test$Class, prob[,2], plotit = TRUE)


# XGBoost

# Convert class labels from factor to numeric

labels <- up_train$Class

y <- recode(labels, 'Not_Fraud' = 0, "Fraud" = 1)

set.seed(42)

xgb <- xgboost(data = data.matrix(up_train[,-30]), 
               label = y,
               eta = 0.1,
               gamma = 0.1,
               max_depth = 10, 
               nrounds = 300, 
               objective = "binary:logistic",
               colsample_bytree = 0.6,
               verbose = 0,
               nthread = 7,
)

xgb_pred <- predict(xgb, data.matrix(test[,-30]))

roc.curve(test$Class, xgb_pred, plotit = TRUE)



#Atalhos


head(data_base)
names(data_base)
summary(data_base)
str(data_base)
str(df)
head(df)
