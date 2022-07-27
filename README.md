# TÉCNICAS DE BALANCEAMENTO DE DADOS DA DETECÇÃO DE FRAUDES


# Contextualização

* Este trabalho investiga quatro técnicas de balanceamento dos dados, usando para isso um algoritmo de classificação por árvore de decisão e uma base de dados pública, Credit-Fraud, do repositório Kaggle, com registros de transações financeiras com e sem fraude. O desempenho das técnicas foi mensurado por meio de suas curvas ROC. Todos os métodos investigados levaram o algoritmo de classificação a ter um desempenho superior em relação ao seu desempenho quando aplicado à base original sem tratamento, isto é, sem o balanceamento. Comprovou-se, dessa forma, a eficácia dessas técnicas, que podem então ser aplicadas na solução de relevantes problemas reais.



## Pré-requesitos

Caso o leitor tenha o desejo de executar esse projeto em sua maquina, você deve realizar os seguintes passos listados abaixo.

* Instalar o `software R`
* Necessario uma conta na plataforma (ou site ) `Kaggle`, caso o leitor tenha interesse em verificar a origem dos dados

## Arquivos do projeto

* `Over_Under.R`: Script atraves da linguagem R
* 'creditcard.csv' : Base de dados creditcard em formato csv
