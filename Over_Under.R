# Instalação dos pacotes

installed.packages("tidyverse")
installed.packages("Caret")
installed.packages("caTools")
installed.packages("ROSE")
installed.packages("rpart")
install.packages('SMOTE')

library(tidyverse)
library(caret)
library(caTools)
library(ROSE)
library(rpart)
library(Rborist)


# Carregando a base de dados

data_base <- read.csv(file = 'creditcard.csv',header = T,sep = ",")

# Preparando os dados

#Removendo a variavel 'Time'

df <- data_base[,-1]


# Transformando a variavel classe em uma variavel de factor

df$Class <- as.factor(df$Class)
levels(df$Class) <- c("Not_Fraud", "Fraud")

#Scalanado a variaveis numericas

df[,-30] <- scale(df[,-30])

head(df)

# Dividindo a base de dados em Treino e Teste

set.seed(123)
split <- sample.split(df$Class, SplitRatio = 0.7)
train <-  subset(df, split == TRUE)
test <- subset(df, split == FALSE)

# Escolhendo metodo de amostra

# Verificando a quantidade de classes propocional na variavel

table(train$Class)
table(test$Class)
table(df$Class)

# Dividindo os dados utilizando os metodos de amostragem

# Under - Sampling

set.seed(9560)

down_train <- downSample(x = train[, -ncol(train)],
                         y = train$Class)
table(down_train$Class)



# Over - Sampling

set.seed(9560)
up_train <- upSample(x = train[, -ncol(train)],
                     y = train$Class)

table(up_train$Class)

# smote

set.seed(9560)
smote_train <- SMOTE(Class ~ ., data  = train)

table(smote_train$Class)

# rose

set.seed(9560)
rose_train <- ROSE(Class ~ ., data  = train)$data 

table(rose_train$Class)


# (Árvore de Decisão)

# Verificando o resultado da arvore de Decisão utilizando os dados desbalanceados.

set.seed(5627)

orig_fit <- rpart(Class ~ ., data = train)

rpart.plot(orig_fit,type = 3)

# Avaliando o desempenho do modelo com dados desbalanceados com teste

pred_orig <- predict(orig_fit, newdata = test, method = "class")

roc.curve(test$Class, pred_orig[,2], plotit = TRUE)


# Árvore de decisão em várias técnicas de amostragem

set.seed(5627)

# Construindo o modelo under - Sampling

down_fit <- rpart(Class ~ ., data = down_train)

set.seed(5627)

# Construindo o modelo up - sampling

up_fit <- rpart(Class ~ ., data = up_train)

set.seed(5627)

# Construindo o modelo SMOTE

smote_fit <- rpart(Class ~ ., data = smote_train)

set.seed(5627)
 
# construindo o modelo Rose
rose_fit <- rpart(Class ~ ., data = rose_train)

# AUC com Under-sampled dados

pred_down <- predict(down_fit, newdata = test)

print('Fitting model to downsampled data')
roc.curve(test$Class, pred_down[,2], plotit = FALSE)

# AUC com Over-sampled dados
pred_up <- predict(up_fit, newdata = test)

print('Fitting model to upsampled data')
roc.curve(test$Class, pred_up[,2], plotit = FALSE)

# Auc com Smote dados
pred_smote <- predict(smote_fit, newdata = test)

print('Fitting model to smote data')
roc.curve(test$Class, pred_smote[,2], plotit = FALSE)

# Auc com Rose dados
pred_rose <- predict(rose_fit, newdata = test)

print('Fitting model to rose data')
roc.curve(test$Class, pred_rose[,2], plotit = FALSE)
