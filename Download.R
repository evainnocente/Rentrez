
#Download.R script


#This line creates an object of the IDs 
#of 3 strains of Borrelia burgdorfieri 
ncbi_ids <- c("HQ433692.1","HQ433694.1","HQ433691.1")

#Loading the rentrez library
library(rentrez)  

#retrieves information from an NCBI database
Bburg<-entrez_fetch(db = "nuccore", id = ncbi_ids, rettype = "fasta")

#splitting the sequences create a new object 
#called Sequences that contains 3 elements: 
#one for each sequence 
Sequences<-strsplit(Bburg,split="\n\n",fixed=FALSE)
print(Sequences)

#convert list object to dataframe

Sequences<-unlist(Sequences)

#Using regular expressions to separate 
#the sequences from the headers
#and making a dataframe
header<-gsub("(^>.*sequence)\\n[ATCG].*","\\1",Sequences)

seq<-gsub("^>.*sequence\\n([ATCG].*)","\\1",Sequences)

Sequences<-data.frame(Name=header,Sequence=seq)
 
#Removing the newline characters from Sequences

sequencecolumn<-Sequences$Sequence
Sequences$Sequence<-gsub("\n","",sequencecolumn)

#Outputting the data frame to a file called sequences.csv
write.csv(Sequences,"C:/Users/evain/OneDrive - Queen's University/university/BIOL 432/Week 6/Rentrez\\Sequences.csv", row.names=FALSE)
