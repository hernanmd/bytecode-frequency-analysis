install.packages("UpSetR")
install.packages("dplyr")

library(dplyr)
library(UpSetR)

# Do not forget to set the working directory
setwd("")
dfrm = read.table('Morphic-compiled-methods.csv', sep=",")

# changing row names of data frame
format_df <- dfrm[,-1]
rownames(format_df) <- dfrm[,1]
row.names(format_df)

# changing column names of data frame
colnames(format_df)
dfrm <- format_df                         # Duplicate data frame
colnames(dfrm) <- format_df[1, ]          # Convert first row to header
dfrm <- dfrm[- 1, ]                       # Remove first row of data
colnames(dfrm)

rm(dfrm,format_df)
# Sort by class/method name
sorted_df <- (dfrm[order(row.names(dfrm)), ])

# Get the logical "matrix" (data frame)
logical_matrix <- sorted_df > 0
# Convert logical matrix to 1 and 0 matrix
df_final <- as.data.frame(logical_matrix)
df_final <- df_final * 1

# Plot
upset(df_final)

