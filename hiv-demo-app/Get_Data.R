setwd("/Users/usaid/Desktop/Producing Data Products/Assignment/hiv-demo-app")
in.name <- "hiv_prevalence.csv"
out.name <- "hiv_data.RData"
ds <- read.csv(paste(getwd(), in.name, sep = "/"), stringsAsFactors = FALSE)
save(ds, file = paste(getwd(), out.name, sep = "/"))