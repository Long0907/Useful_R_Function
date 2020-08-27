#Working directory :
#"/Users/zhenglong/OneDrive - University of Southern California/Data_science/R for data science/Practice/HLA-DRB1"

HLA_DR <- read.csv("HLA-DRB1 Expression Public 20Q2.csv")
View(HLA_DR)


#higher expression log2.TPM.1 > 2
high <- HLA_DR[HLA_DR$log2.TPM.1.>=1, ]

a = as.character((levels(high$Lineage)))

library(xlsx)
# cancertype<- high[high$Lineage==a[2],]
# write.xlsx(cancertype, file="HLA_DRB1_explevel.xlsx", sheetName=a[2], append=FALSE, row.names=FALSE)
df <- data.frame(No_content = c(0,0))
for (i in c(1:34)){
    if (sum(high$Lineage==a[i])>0){
      print(paste("creating sheet", a[i], sep = ":"))
      cancertype<- high[high$Lineage==a[i],]
      cancertype <- cancertype[order(cancertype$log2.TPM.1.,decreasing = T),]
      write.xlsx(cancertype, file="HLA_DRB1_explevel.xlsx", sheetName=a[i], append=TRUE, row.names=FALSE, col.names = T)
    }
  else{
    write.xlsx(df, file="HLA_DRB1_explevel.xlsx", sheetName=a[i], append=TRUE, row.names=FALSE)
  }
    
}





