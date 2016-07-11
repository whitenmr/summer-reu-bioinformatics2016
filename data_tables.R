#the purpose of this file is to convert a VCF file to a data frame that can be read and worked with in R. We will alos want to pull data from the web that has already been set up 
#to let people compare their data to others. 
vcf_data_table <- function(file1){
my_data = readLines(file1)

# prints out the vector 
#head(my_data)

header_lines = grep("^##", my_data)
#prints out the vector line numbers 
#head(header_lines)


header_info = my_data[header_lines]
part= my_data[-header_lines]
part[1]= substring(part[1], 2, nchar(part[1]))
#head(part)


write(part, file = "final.txt")
df <- read.table("final.txt", header= TRUE)
rfile <- "final.txt"
return(rfile)
}

#head(df)

