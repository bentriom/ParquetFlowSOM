library(devtools)
library(tidyverse)
library(arrow)

load_all(".")

path_fcs <- "D:/Projets Artelys/PORTRAIT/Git/omics_analysis/tests/example_size_csv/R7427_D0.fcs"
path_parquet_test <- paste0("D:/Projets Artelys/PORTRAIT/Git/omics_analysis/",
                            "tests/sample_parquet")
path_parquet_batch <- paste0("D:/Projets Artelys/PORTRAIT/Git/omics_analysis/",
                             "results/portrait_batch1/datasets/parquet_cytof/")
data_pq <- open_dataset(path_parquet_batch) %>% select(-sample)
data_pq_test <- open_dataset(path_parquet_test) %>% select(-sample)
# slice_sample shouldn't be used
# map_batches works but is experimental
# data_pq %>% map_batches(~ as_record_batch(sample_frac(as.data.frame(.), 1e-3))) %>% collect()

# data_pq_nyc <- open_dataset("C:/Users/mbentriou/Documents/NYC taxi/")

# It's strange: slice_sample doesn't work with only one file specified in path_parquet
# data_pq %>% slice_sample(n = 1) %>% collect()

# data_pq %>% to_duckdb() %>% slice_min(order_by=random(), n=100000) %>% collect()

# Big troubles with C binding...
# fsom <- ReadInput(as.matrix(data_pq %>% collect()))
fsom <- ReadInput(data_pq_test)
BuildSOM(fsom)

# source("tests/read_inputs.R")