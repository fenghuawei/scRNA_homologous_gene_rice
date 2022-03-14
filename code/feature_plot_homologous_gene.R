library(Seurat)
library(ggplot2)
rds <- readRDS("rice.Rdata")
DefaultAssay(rds) <- "RNA"
feature_plot <- function(gene_list){
#print(gene_list)
pngname <- paste("Plot/",gene_list[1],"_","feature_plot.png",sep="")
#print(pngname)
png(file=pngname)
p1<-FeaturePlot(rds, features = gene_list, max.cutoff = 3, cols = c("grey","red"))
print(p1)
dev.off()
}
table <- read.table("homolog_cluster_expr_unique.txt",header=F,sep="\t")
for (key in table$V2){
kk <- gsub('\\[|\\]','',key)
kkk <- unlist(strsplit(kk,split=','))
kkkk<- gsub(" ", "", kkk, fixed=TRUE)
feature_plot(kkkk)
}





