library(ggplot2)
library(Seurat)
rds <- readRDS("rice.Rdata")
DefaultAssay(rds) <- "RNA"
table <- read.csv("leaf_Marker.csv",header=F)
type <- unique(table$V2)
for (key in type){
ukrine_brave = table[table$V2==key,]$V1
file_name = paste("Marker/",key[1],".png",sep="")
dpi=300
#png(file=file_name)
png(file=file_name, width = dpi*16, height = dpi*12, units = "px",res = dpi,type='cairo')
#p1<-FeaturePlot(rds, features = ukrine_brave, max.cutoff = , cols = c("grey","red"))
# min.cutoff = "q10", max.cutoff = "q90")
#p1<-FeaturePlot(rds, features = ukrine_brave, min.cutoff = "q10", max.cutoff = "q90",  cols = c("grey","red"))
p1<-FeaturePlot(rds, features = ukrine_brave,  cols = c("grey","red"))
print(p1)
dev.off()
}

