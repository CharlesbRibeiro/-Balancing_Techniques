ENGLISH VERSION (Texto em Português abaixo)

# FRAUD DETECTION DATA BALANCING TECHNIQUES


# Dataset context


* It is important for credit card companies to be able to recognize fraudulent credit card transactions so that customers are not charged for items they did not purchase.

* The dataset contains credit card transactions made in September 2013 by European cardholders. This dataset features transactions that took place over two days, where we have 492 frauds out of 284,807 transactions. The dataset is highly unbalanced, the positive class (frauds) accounts for 0.172% of all transactions.

# Project content

* **This work** investigates four data balancing techniques, using a decision tree classification algorithm and a public database, Credit-Fraud, from the Kaggle repository, with records of financial transactions with and without fraud . The performance of the techniques was measured through their ROC curves. All investigated methods led the classification algorithm to have a superior performance in relation to its performance when applied to the original base without treatment, that is, without balancing. Thus, the effectiveness of these techniques was proven, which can then be applied in the solution of relevant real problems.

## Prerequisites

If the reader has the desire to run this project on his machine, he must perform the following steps listed below.

* Install the `software R`
* It will be necessary to install libraries (or packages) present in the `Over_Under.R` script
* An account on the `Kaggle` platform (or website) is required if the reader is interested in downloading the data set. The download link is at the end of this page.

## Project files

* `Over_Under.R`: Script using the R language


## Data source

* https://www.kaggle.com/datasets/mlg-ulb/creditcardfraud


Versão em Português


# TÉCNICAS DE BALANCEAMENTO DE DADOS DA DETECÇÃO DE FRAUDES


# Contexto do conjunto de dados


* É importante que as empresas de cartão de crédito sejam capazes de reconhecer transações fraudulentas com cartão de crédito para que os clientes não sejam cobrados por itens que não compraram.

* O conjunto de dados contém transações feitas por cartões de crédito em setembro de 2013 por titulares de cartões europeus. Este conjunto de dados apresenta transações que ocorreram em dois dias, onde temos 492 fraudes em 284.807 transações. O conjunto de dados é altamente desequilibrado, a classe positiva (fraudes) responde por 0,172% de todas as transações.

# Conteudo do projeto

* **Este trabalho** investiga quatro técnicas de balanceamento dos dados, usando para isso um algoritmo de classificação por árvore de decisão e uma base de dados pública, Credit-Fraud, do repositório Kaggle, com registros de transações financeiras com e sem fraude. O desempenho das técnicas foi mensurado por meio de suas curvas ROC. Todos os métodos investigados levaram o algoritmo de classificação a ter um desempenho superior em relação ao seu desempenho quando aplicado à base original sem tratamento, isto é, sem o balanceamento. Comprovou-se, dessa forma, a eficácia dessas técnicas, que podem então ser aplicadas na solução de relevantes problemas reais.

# Artigo

Desenvolve e publiquei um artigo onde descrevo todas as técnicas e também cito todas as referências utilizadas para desenvolvimento desse projeto (ou artigo).

* https://www.linkedin.com/pulse/an%25C3%25A1lise-de-t%25C3%25A9cnicas-balanceamento-dados-na-detec%25C3%25A7%25C3%25A3o-barros-ribeiro/?trackingId=eMjUYp3lRrqpLmNVjZvVBw%3D%3D


## Pré-requesitos

Caso o leitor tenha o desejo de executar esse projeto em sua maquina, você deve realizar os seguintes passos listados abaixo.

* Instalar o `software R`
* Sera necessario a instalação de bibliotecas (ou Pacotes) presente no script `Over_Under.R` 
* Necessário uma conta na plataforma (ou site ) `Kaggle`, caso o leitor tenha interesse em fazer o download do conjunto de dados. O link para download encontra-se no final dessa pagina. 

## Arquivos do projeto

* `Over_Under.R`: Script atraves da linguagem R


## Origem dos dados

* https://www.kaggle.com/datasets/mlg-ulb/creditcardfraud
