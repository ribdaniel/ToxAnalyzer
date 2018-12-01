library(ggplot2)
var <- read.table('benzene_organisms.txt', header = FALSE, sep = '\t')
pdf('benzene.pdf')
ggplot(var, aes(x=(var$V1), y=(var$V2))) + geom_bar(stat='identity') + labs(title='# of genes interacting with benzene in different organisms',
  x='Organisms', y='# of genes') + coord_flip()+ theme(axis.title= element_text(face='bold'))
dev.off()