options(width = 1000)

install.packages("plyr")
library("plyr")
setwd("/Users/usaid/datasciencecoursera/UCI HAR Dataset")

train.file <- "train/X_train.txt"
test.file <- "test/X_test.txt"
feature.file <- "features.txt"
train.subj <- "train/subject_train.txt"
test.subj <- "test/subject_test.txt"
y.train.file <- "train/y_train.txt"
y.test.file <- "test/y_test.txt"
act.lab.file <- "activity_labels.txt"

features <- readLines(feature.file)

train.ds <- read.table(train.file, stringsAsFactors=FALSE)
test.ds <- read.table(test.file, stringsAsFactors=FALSE)
train.ds.subj <- read.table(train.subj, stringsAsFactors=FALSE)
test.ds.subj <- read.table(test.subj, stringsAsFactors=FALSE)
train.y <- read.table(y.train.file, stringsAsFactors=FALSE)
test.y <- read.table(y.test.file, stringsAsFactors=FALSE)

activities <- read.table(act.lab.file, stringsAsFactors=FALSE)
names(activities) <- c("act.id", "Activity")

train.ds <- cbind(train.ds.subj, train.y, train.ds)
test.ds <- cbind(test.ds.subj, test.y, test.ds)
all.ds <- rbind(test.ds, train.ds)

rm(train.ds)
rm(test.ds)

names(all.ds) <- c("subject", "act.id", features)

all.ds <- merge(all.ds, activities)

mean.cols <- grep("mean", features)
st.dev.cols <- grep("std", features)

needed.cols <- c(mean.cols, st.dev.cols)

sub.df <- all.ds[,needed.cols]

tidy <- ddply(.data = all.ds, .variables = c("subject", "Activity"), .fun = numcolwise(mean))
write.table(tidy, file="tidy_data_set.csv", sep=",",row.names=F)
