#GO termn and accession annotation, and data aggreggation. 


counts <- read.csv("data_set/GSE145642_Amor_RNASeq.cnt.csv.gz", header = T)

fun <- counts[1:10,1:3]
View(fun)
#retreive GOID------- 
library(biomaRt)
  # select mart and data set
bm <- useMart("ensembl")
bm <- useDataset("mmusculus_gene_ensembl", mart=bm)

  # Get ensembl gene ids and GO terms
EG2GO <- getBM(mart=bm, attributes=c('ensembl_gene_id','go_id'),
               filters = 'ensembl_gene_id', values = fun$ID)


library(GO.db)


df <- select(GO.db, keys = EG2GO$go_id, keytypes = "GOID",columns = "TERM")

df$ENSM <- EG2GO$ensembl_gene_id

df$GOID[df$GOID==""] <- NA

df[is.na(df)] <- "NA" #may be not necessary.


#aggreat contents based on groups..
df_2 <- aggregate(x = list(GOID=df$GOID, TERM=df$TERM),
                  by=list(ENSM=df$ENSM), paste, collapse="/")



#------stop here -------------

library(biomaRt)
# select mart and data set
bm <- useMart("ensembl")
bm <- useDataset("mmusculus_gene_ensembl", mart=bm)

# Get ensembl gene ids and GO terms
EG2GO <- getBM(mart=bm, attributes=c('ensembl_gene_id','go_id'),
               filters = 'ensembl_gene_id', values = fun$ID)
