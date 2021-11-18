
import numpy 
import pandas
import math
from sklearn.linear_model import LinearRegression
from sklearn.preprocessing import LabelEncoder

df = pandas.read_csv("titanic_MD.csv")
dfRenewed = pandas.DataFrame()

dfRenewed["ID"] = df["PassengerId"]
dfRenewed["Sobrevivio?"] = df["Survived"]
dfRenewed["Clase"] = df["Pclass"]
dfRenewed["Nombre"] = df["Name"]
dfRenewed["Ticket"] = df["Ticket"]
dfRenewed["Cabina"] = df["Cabin"]

le = LabelEncoder()
linear = LinearRegression()
dfNull = df.isna().sum()

# Edad -- Imputacion del promedio
promEdad = df["Age"].mean()
promEdad = math.floor(promEdad)
dfRenewed["Edad"] = df["Age"].fillna(promEdad).astype(int)

# SibSp -- Imputacion de la moda
modaSib = df["SibSp"].mode()
modaSib = int(modaSib)
dfRenewed["SibSp"] = df["SibSp"].fillna(modaSib)

# Parch -- Imputacion de la moda
modParch = int(df["Parch"].mode())
dfRenewed["Parch"] = df["Parch"].fillna(modParch).astype(int)

# Tarifa -- Imputación del promedio
promFare = int(df["Fare"].mean())
dfRenewed["Tarifa"] = df["Fare"].fillna(promFare).astype(int)

# Embarque -- Imputacion de la moda
mask =  df["Embarked"].isnull()
df['EmbarkedNUMS'] = le.fit_transform(df['Embarked'])
df["EmbarkedNUMS"] = df["EmbarkedNUMS"].where(mask != True, numpy.NaN)

modEmb = int(df["EmbarkedNUMS"].mode())
df["Embarked2"] = df["EmbarkedNUMS"].fillna(modEmb).astype(int)
dfRenewed["Embarque"] = le.inverse_transform(df["Embarked2"])

# Género -- Regresion lineal
df["SexNums"] = df["Sex"].apply(lambda x: numpy.NaN if x == "?" else x)
mask =  df["SexNums"].isnull()
df["SexNums"] = le.fit_transform(df["SexNums"])
df["SexNums"] = df["SexNums"].where(mask != True, numpy.NaN)

testdf = df[df["SexNums"].isnull()==True]
testdf = testdf.drop(["PassengerId", "Name", "Sex", "Age", "SibSp", "Parch",
                       "Ticket", "Fare", "Embarked", "EmbarkedNUMS", "Embarked2", "Cabin"], axis=1)
traindf = df[df["SexNums"].isnull()==False]
traindf = traindf.drop(["PassengerId", "Name", "Sex", "Age", "SibSp", "Parch", 
                       "Ticket", "Fare", "Embarked", "EmbarkedNUMS", "Embarked2","Cabin"], axis=1)

y2 = traindf["SexNums"]

traindf.drop("SexNums", axis=1,inplace=True)
linear.fit(X=traindf,y=y2)

testdf.drop("SexNums", axis=1,inplace=True)
pred = linear.predict(testdf)
testdf["SexNums"]= pred
testdf["SexNums"] = round(testdf["SexNums"])

df["Sex2"] = df["SexNums"].fillna(testdf["SexNums"]).astype(int)
dfRenewed["Genero"] = le.inverse_transform(df["Sex2"])

# Edad -- Regresion lineal -------------------------------------------------------------------------------------------------------------------------
#sobrevivió, la tarifa y la clase del ticket.
testdf = df[df["Age"].isnull()==True]
testdf = testdf.drop(["PassengerId", "Name", "Sex", "SibSp", "Parch", "EmbarkedNUMS", "SexNums", "Sex2",
                       "Ticket", "Fare", "Embarked", "EmbarkedNUMS", "Embarked2", "Cabin"], axis=1)
traindf = df[df["Age"].isnull()==False]
traindf = traindf.drop(["PassengerId", "Name", "Sex", "SibSp", "Parch", "EmbarkedNUMS", "SexNums", "Sex2",
                       "Ticket", "Fare", "Embarked", "EmbarkedNUMS", "Embarked2", "Cabin"], axis=1)
y2 = traindf["Age"]

traindf.drop("Age", axis=1,inplace=True)
linear.fit(X=traindf,y=y2)

testdf.drop("Age", axis=1,inplace=True)
pred = linear.predict(testdf)
testdf["Age"]= pred
testdf["Age"] = round(testdf["Age"])
dfRenewed["EdadLr"] = df["Age"].fillna(testdf["Age"]).astype(int)

# print(df)
print(dfRenewed)

# dfNullR = dfRenewed.isna().sum()
# print(dfNullR)

dfC = pandas.read_csv("titanic.csv")
# print(dfC)

dfRenewed.compare

comparador = pandas.DataFrame()

comparador["MatchGenero"] = numpy.where(dfRenewed["Genero"] == dfC["Sex"], 'True', 'False')
comparador["MatchEdad"] = numpy.where(dfRenewed["Edad"] == dfC["Age"], 'True', 'False')
comparador["MatchEdadLr"] = numpy.where(dfRenewed["EdadLr"] == dfC["Age"], 'True', 'False')
comparador["MatchSibSp"] = numpy.where(dfRenewed["SibSp"] == dfC["SibSp"], 'True', 'False')
comparador["MatchParch"] = numpy.where(dfRenewed["Parch"] == dfC["Parch"], 'True', 'False')
comparador["MatchTarifa"] = numpy.where(dfRenewed["Tarifa"] == dfC["Fare"], 'True', 'False')
comparador["MatchEmbarque"] = numpy.where(dfRenewed["Embarque"] == dfC["Embarked"], 'True', 'False')

nombresOrig = ["Sex", "Age", "Age", "SibSp", "Parch", "Fare", "Embarked"]
nombresRenw = ["Genero", "Edad", "EdadLr", "SibSp", "Parch", "Tarifa", "Embarque"]
connti = 0

contMatches = []
for i in comparador:
    contMatches.append(comparador[i].value_counts())
    try:
        contMatches.append(dfRenewed[nombresRenw[connti]].mean())
        contMatches.append(dfC[nombresOrig[connti]].mean())
    except:
        pass
    connti += 1

# print(contMatches)

# print("\nComparacion contra data original\n")
# i = 0
# while i <= len(contMatches)-1:
#     # print(str(type(contMatches[i])))
#     if str(type(contMatches[i])) == "<class 'pandas.core.series.Series'>":
#         print("")
#         print("Columna ---")
#         print(contMatches[i])
#     else:
#         print("\nMedia Data Modificada")
#         print(round(contMatches[i],2))
#         print("Media Data Original")
#         print(round(contMatches[i+1],2))
#         i += 1
#     i += 1


