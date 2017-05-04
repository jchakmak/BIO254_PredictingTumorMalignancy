
# Load in the data
df = read.csv("proj1data.csv")

# Bare_nuclei column (16 records with "?")
table(df[7])
# Class column
table(df[11])

# Remove records with question marks
df <- df[-grep("\\?", df$Bare_nuclei),]

### Split data into training, validation, and test sets
library(caret)
set.seed(1234)
partition <- createDataPartition(df$Class, p=.8, list=FALSE, times=1)
trainingSet <- df[partition,]
testingSet <- df[-partition,]

#---------------------------------------------------------------
# source:
# http://trevorstephens.com/kaggle-titanic-tutorial/r-part-5-random-forests/

# modeling
library(randomForest)
set.seed(123)
# random forest
fit <- randomForest(as.factor(Class) ~ Thickness + Uni_size + Uni_shape + Marg_adhesion
                    + SECS + Bare_nuclei + Bland_chrom + Normal_nuclei + Mitoses,
                    data=trainingSet, importance=TRUE, ntree=2000)

# variable importance
varImpPlot(fit)

# test with testing data
pred <- predict(fit, testingSet)
table(pred, testingSet$Class)



