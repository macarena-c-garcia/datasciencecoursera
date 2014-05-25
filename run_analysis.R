# This is a global parameter, not necessary, but I like to add it for printing large datasets in the consol
options(width = 1000)

install.packages("plyr")
library("plyr")
setwd("/Users/usaid/datasciencecoursera/UCI HAR Dataset")

# Set up variables to match the file names
train.file <- "train/X_train.txt"
test.file <- "test/X_test.txt"
feature.file <- "features.txt"
train.subj <- "train/subject_train.txt"
test.subj <- "test/subject_test.txt"
y.train.file <- "train/y_train.txt"
y.test.file <- "test/y_test.txt"
act.lab.file <- "activity_labels.txt"

# read in the column names for the data from the features file
features <- readLines(feature.file)

# read in all of the data, as well as the subjects and activities
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

# rename all of the columns 
names(all.ds) <- c("subject", "act.id", features)

all.ds <- merge(all.ds, activities)


# searches all the column names for either the word 'mean' or 'std'
# This returns an indexed list for each variable for which column has those names
mean.cols <- grep("mean", features)
st.dev.cols <- grep("std", features)

# Combines the two indexes into one
needed.cols <- c(mean.cols, st.dev.cols)

# Subsets only the columns that have 'mean' or 'std' in the name
sub.df <- all.ds[,needed.cols]

tidy <- ddply(.data = all.ds, .variables = c("subject", "Activity"), .fun = numcolwise(mean))