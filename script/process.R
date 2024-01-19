setwd("~/Workspace/test_github/height-predictor/")
library(dplyr)

samples_df <- read.table("data/processed/samples_list.txt", col.names = "sample_id")
genotyped_df <- read.table("data/processed/EUR.QC.txt", sep = "\t")


genotyped_df$V17 <- as.integer(genotyped_df$V17)
# Process data to fit in models
transpose_genotyped_df <- genotyped_df %>% 
  select(., -ncol(genotyped_df)) %>% 
  t() %>% 
  as.data.frame() %>%  
  setNames(.[1, ]) %>% 
  slice(-1)

transpose_genotyped_df <- transpose_genotyped_df %>% 
  mutate(sample_id = samples_df$sample_id) %>% 
  select(sample_id, everything())

# Create a stimulate column
set.seed(42)

# Simulate height based on other factors
transpose_genotyped_df$simulated_height <- 150 + rnorm(nrow(transpose_genotyped_df), mean = 0, sd = 10)

# Export dataframe to csv file
write.csv(transpose_genotyped_df, "processed_data.csv", sep = "\t", row.names = FALSE)
