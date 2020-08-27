

#####All you need is set your right working directory. Run from source, You'll get a csv
# file in the wd.#######
######extract abstract#######
library(readtext)
#Abstract extraction from pubmed download fucntion.

extractabs <- function(fname){
  a <- readtext(fname)
  abstract_list <- unlist(strsplit(a$text, "\n\n\n"))
  abstract_5 <- unlist(lapply(abstract_list, function(x) unlist(strsplit(x, "\n\n"))[5]))
  abstract_6 <- unlist(lapply(abstract_list, function(x) unlist(strsplit(x, "\n\n"))[6]))
  abstract <- paste(abstract_6, abstract_5, sep = ',')
  return(unlist(abstract))
}

#check file list in the working directory
filelist <- list.files(pattern = ".*.txt")
abstract_only <- lapply(filelist, function(x) extractabs(x))

#creat a blank data.frame
abs_column <- data.frame(ABSTRACT=c())

#iterate through the extracted abstracts.

for (i in seq(1, length(filelist), by=1)){
  new_data_frame <- data.frame(ABSTRACT=unlist(abstract_only[i]))
  abs_column <- rbind.data.frame(abs_column,new_data_frame,stringsAsFactors=FALSE)
}

######extract_PMID######

library(pubmed.mineR)
stringsAsFactors = FALSE 
#read all txt files in the working directory
filelist <- list.files(pattern = ".*.txt")
#check the txt files.
filelist

#read all txt files and store as a list. 
readfile <- lapply(filelist, function(x) readabsnew(x))

#creat a blank data.frame. 

pmid_column <- data.frame(PMID=c())
#iterate 

for (i in seq(1, length(filelist), by=1)){
  new_data_frame <- data.frame(PMID = readfile[[i]]@PMID)
  pmid_column <- rbind.data.frame(pmid_column,new_data_frame,stringsAsFactors=FALSE)
}


car_abstract <- cbind.data.frame(PMID = pmid_column$PMID, 
                                 Abstract = as.character(abs_column$ABSTRACT),
                                 stringsAsFactors=FALSE)




write.csv(car_abstract, file = 'CAR_Abstract.csv', )


