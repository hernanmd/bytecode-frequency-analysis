

# Do not forget to set the working directory
setwd("")
dfrm = read.table('FileSystem-compiled-methods.csv', sep=",")

# changing row names of data frame
format_df <- dfrm[,-1]
rownames(format_df) <- dfrm[,1]

data_new <- format_df                         # Duplicate data frame
colnames(data_new) <- format_df[1, ]          # Convert first row to header
data_new <- data_new[- 1, ]                 # Remove first row of data

sorted_df <- (data_new[order(row.names(data_new)), ])

View(sorted_df)

output_file <- "FileSystem-Sorted-by-class.csv"
write.csv(sorted_df, output_file, row.names=TRUE)
