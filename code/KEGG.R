library(cowplot)
library(biomaRt)

require(AnnotationHub)
hub <- AnnotationHub()
rice <- hub[['AH96212']]
require(clusterProfiler)

library(ggplot2)




list_gene <- function(gene_list){
m = c()
for (key in gene_list ){
kk <- gsub('\\[|\\]','',key)
kkk <- unlist(strsplit(kk,split=','))
kkkk<- gsub(" ", "", kkk, fixed=TRUE)
m <- append(m,kkkk)
#return(m)
}
return(m)
}
table <- read.table("homolog_cluster_expr_unique.txt",header=F,sep="\t")
genes_ten <- table[table$V3 >10,]$V2
genes_five <- table[table$V3 <=10 & table$V3 >5,]$V2
genes_one <- table[table$V3 <=5 ,]$V2
genes_ten_list <- list_gene(genes_ten)
genes_five_list <- list_gene(genes_five)
genes_one_list <- list_gene(genes_one)
ensembl = useMart(biomart = "plants_mart",host = "http://plants.ensembl.org",dataset="osativa_eg_gene")
GO_enrich <- function(generow,names){
supplements <- getBM(attributes =c("ensembl_gene_id",'entrezgene_id'),filters = "ensembl_gene_id",values = generow,mart = ensembl)
keiv <- supplements$entrezgene_id
keiv<-na.omit(keiv)
keiv <- unique(keiv)


BP  = enrichGO(gene = keiv,OrgDb = rice,ont = "BP",pAdjustMethod = "BH",pvalueCutoff  = 1,qvalueCutoff  = 1,readable= TRUE)
MF= enrichGO(gene = keiv,OrgDb = rice,ont = "MF",pAdjustMethod = "BH",pvalueCutoff  = 1,qvalueCutoff  = 1,readable=TRUE)
CC=enrichGO(gene = keiv,OrgDb = rice,ont = "CC",pAdjustMethod = "BH",pvalueCutoff  = 1,qvalueCutoff  = 1,readable=TRUE)
pBP <- barplot(BP,showCategory=20,drop=T)+theme(axis.text.y = element_text(size = 10),legend.text = element_text
(size = 16),legend.title = element_text(size = 16))
pMF <- barplot(MF,showCategory=20,drop=T)+theme(axis.text.y = element_text(size = 10),legend.text = element_text(size = 16),legend.title = element_text(size = 16))
pCC=barplot(MF,showCategory=20,drop=T)+theme(axis.text.y = element_text(size = 10),legend.text = element_text(size= 16),legend.title = element_text(size = 16))
file_name = paste("GO/",names,".png",sep="")
png(file_name)

pq <- plot_grid(pBP,pMF,pCC,ncol=1,align='v')
print(pq)
#print(pMF)
dev.off()
}
#GO_enrich(genes_ten_list,"ten")
#GO_enrich(genes_five_list,"five")
#GO_enrich(genes_one_list,"one")

#KEGG
rice_kegg <- clusterProfiler::download_KEGG("dosa")
kegg_anno <-function(gene_list,title){
gene_list <- paste0(gene_list[!is.na(gene_list)], "-01")
rap_id <- gsub("g","t",gene_list)
ekegg <- enrichKEGG(rap_id, organism = "dosa", pAdjustMethod = "none")
#p1 <- barplot(ekegg,showCategory=20,drop=T)+theme(axis.text.y = element_text(size = 20),legend.text = element_text(size = 50),legend.title = element_text(size = 20))
title = title
p1 <- barplot(ekegg,showCategory=20,drop=T)+ theme(axis.text.y = element_text(size = 26),axis.text.x = element_text(size = 26),axis.title.x=element_text(size = 26),legend.text = element_text(size = 16),legend.title = element_text(size = 16))
#p1 <- barplot(ekegg,showCategory=20,drop=T,text.width=60,cex=1) + ggtitle(title) + theme(plot.title = element_text(hjust = 0.5,size=50))
#p1 <- ggplot(ekegg,aes(x=reorder(Descrption,GeneRatio),y=GeneRatio)) + labs(x="",y='GeneRatio',fill='')+ coord_flip() + ggtitle(title) + theme(plot.title = element_text(hjust = 0.5,size=10))
#p1 <- ggplot(ekegg,aes(x=reorder(Description,Count),y=Count)) + geom_bar(stat='identity')+ labs(x="",y='GeneRatio',fill='')+ coord_flip() + ggtitle("big") + theme(plot.title = element_text(hjust = 0.5,size=10))
return(p1)
}
liu <- kegg_anno(genes_one_list,"A")
guan <- kegg_anno(genes_five_list,"B")
zhang <- kegg_anno(genes_ten_list,"C")
dpi = 300
#png("KEGG.png",  width = dpi * 30,height = dpi * 45 ,units = "px",res = dpi ,type = 'cairo')
png("KEGG.png",width = dpi * 15,height = dpi * 18,units = "px",res = dpi,type = 'cairo')
po <- plot_grid(liu,guan,zhang,ncol=1,labels=c("A","B","C"),label_size = 34)
print(po)
dev.off()

#png(file = paste(opt$outdir,"/",group_,'_kegg.png',sep = ''),width = dpi * 10,height = dpi * 6,units = "px",res = dpi,type = 'cairo')



#po <- plot_grid(liu,guan,zhang,ncol=1)
#print(po)
#print(liu)
#dev.off()

