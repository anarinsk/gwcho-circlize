library(circlize)
library(showtext)

font_add_google("Nanum gothic")

colnames(test_data)

mat = as.matrix(test_data[-1]) 
mat
rownames(mat) = test_data$`대학전공`

mat

showtext_auto() 
chordDiagram(mat)


circos.clear()
circos.par(start.degree = 85, clock.wise = FALSE)
chordDiagram(mat)



grid.col = c(S1 = "red", S2 = "green", S3 = "blue",
             E1 = "grey", E2 = "grey", E3 = "grey", E4 = "grey", E5 = "grey", E6 = "grey")

colorMajor = c('red', 'green', 'blue', 'yellow', 'purple')
colorHL = function(num, color, alpha_low=0.1, alpha_high=0.8){
  
  hlcolor = adjustcolor(color[num], alpha.f = alpha_high)
  opcolor = adjustcolor(color, alpha.f = alpha_low)
  opcolor[num] = hlcolor
  
  opcolor
}

colorHL(2,colorMajor)

colorOpp = rep('grey',5) 

grid.col = c(colorMajor, colorOpp)
names(grid.col) = c(test_data$`대학전공`, colnames(test_data)[-1])

grid.col
col(test_data)

png("my_plot.png", width = 2400, height = 2400, res=300, antialias = "subpixel") 

par(cex = 4, mar = c(0, 0, 0, 0))
circos.clear()
circos.par(start.degree = 89, clock.wise = FALSE)
chordDiagram(mat, grid.col = grid.col, 
             row.col = colorHL(5,colorMajor), 
             annotationTrack = c("name","grid"))


## all of your plotting code

dev.off()

