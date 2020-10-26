devtools::install_github('jokergoo/circlize')
library(circlize)

set.seed(999)
mat = matrix(sample(18, 18), 3, 6) 
rownames(mat) = paste0("S", 1:3)
colnames(mat) = paste0("E", 1:6)
mat

chordDiagram(mat)

circos.par(start.degree = 85, clock.wise = FALSE)
chordDiagram(mat)
circos.clear()

grid.col = c(S1 = "red", S2 = "green", S3 = "blue",
             E1 = "grey", E2 = "grey", E3 = "grey", E4 = "grey", E5 = "grey", E6 = "grey")

png("my_plot.png", width = 2400, height = 2400, res=400, antialias = "subpixel") 

circos.clear()
circos.par(start.degree = 89, clock.wise = FALSE)
chordDiagram(mat, grid.col = grid.col, 
             row.col = c("#00FF0010", "#FF000080","#0000FF10"), 
             annotationTrack = c("name","grid"))

## all of your plotting code

dev.off()

