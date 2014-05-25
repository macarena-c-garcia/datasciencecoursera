# This is a global parameter, not necessary, but I like to add it for printing large datasets in the console
options(width = 1000)

# I have added this package to do the mean and sd calculations later
install.packages("plyr")
library("plyr")

# Set yothe working directory to match where the "UCI HAR Dataset" folder is located 
setwd("/Users/usaid/datasciencecoursera/UCI HAR Dataset")

# Set up variables to match the file names
# If the file is not in the root 'UCI HAR Dataset' folder, add the train or test folder prefix...
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
# This gives the data frame some names which will really pay off when performing the merge
names(activities) <- c("act.id", "Activity")

# the cbind command will append columns of data frames as long as the number of rows match
# In this case they all will.  I am adding the subject ID and the activity ID to the large datasets
train.ds <- cbind(train.ds.subj, train.y, train.ds)
test.ds <- cbind(test.ds.subj, test.y, test.ds)

# Similar to cbind, the rbind command will append rows to the bottom of a data frame as long as the columns match
# This is how we combine the train and test data together.
all.ds <- rbind(test.ds, train.ds)

# It is wise to remove large datasets in memory that are no longer needed
# In this case, the original train and test sets.  They are combined now 
rm(train.ds)
rm(test.ds)

# rename all of the columns.  The first one is from the subject file, then the activity
# The rest comes from the feature file of column names
# I am essentially assigning the names of the data frame to a character vector that was created on the fly
# These names are in the correct order for how it is in the data frame, so it matches
names(all.ds) <- c("subject", "act.id", features)

# The merge command is like a join in SQL.  In this case since I named the activity ids as "act.id" beforehand
#        	for both data frames, the merge command will detect this and automatically join based on that field
#		I am basically assigning the activity lables to all of the ID's here
all.ds <- merge(all.ds, activities)


# searches all the column names for either the word 'mean' or 'std'
# This returns an indexed list for each variable for which column has those names
mean.cols <- grep("mean", features)
st.dev.cols <- grep("std", features)

# This combines the two indexes into one
needed.cols <- c(mean.cols, st.dev.cols)

# This subsets only the columns that have 'mean' or 'std' in the name
sub.df <- all.ds[,needed.cols]


# "ddply" is a very powerful aggregation function from the plyr package
#  This allows the user to take the large data frame, choose 2 columns to group by, and then apply a function to the data
#  In this case, I combine the subject and Activity values and group them together so the combination only exists once
#  Each time the data is grouped, a function is perfomed on the subset.
#  By using the "numcolwise(mean)" function, it applies a mean for ever available column
#  This is the tidy dataset that has each subject and Activity combination, and a mean for every column
tidy <- ddply(.data = all.ds, .variables = c("subject", "Activity"), .fun = numcolwise(mean))

