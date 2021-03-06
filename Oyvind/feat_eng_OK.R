features <- variable.names(df)
comp_features <- features[28:51]

comp_df <- df[, which(features %in% comp_features)]

rate_i <- which(comp_features %in% comp_features[seq(1, length(comp_features), 3)])
inv_i <- which(comp_features %in% comp_features[seq(2, length(comp_features), 3)])
rpd_i <- which(comp_features %in% comp_features[seq(3, length(comp_features), 3)])

n <- nrow(comp_df)
lowest_price <- logical(n)
only_avail <- logical(n)
for (i in 1:n){
  lowest_price[i] <- (min(comp_df[i, rate_i], na.rm=TRUE) > -1 && any(!is.na(comp_df[i, rate_i])))
  only_avail[i] <- (min(comp_df[i, inv_i], na.rm=TRUE) == 1 && any(!is.na(comp_df[i, rate_i])))
}

add_df <- data.frame(lowest_price, only_avail)

merged_df <- cbind(no_na_df, add_df)
merged_df <- subset(merged_df, srch_id %in% srch_ids.unique[1:100])
