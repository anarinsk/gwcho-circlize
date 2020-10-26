library(circlize)
library(showtext)

font_add_google("Nanum gothic")

# Making mat from souce data 

gen_mat <- function(df){
  
  mat = as.matrix(df[-1]) 
  rownames(mat) = as.vector(unlist(df[,1]))
  
  mat 
}

colorHL = function(num, color, alpha_high=0.8, alpha_low=0.1){
  
  hlcolor = adjustcolor(color[num], alpha.f = alpha_high)
  opcolor = adjustcolor(color, alpha.f = alpha_low)
  opcolor[num] = hlcolor
  
  opcolor
}

gen_grid_color <- function(matrix, colorM){
  
  ncol = length(mat[1,])
  colorO = rep('grey',ncol) 
  grid.col = c(colorM, colorO)
  names(grid.col) = c(row.names(mat), colnames(mat))
  
  grid.col  
}

plot_hi_chord <- function(mat, n, my_degree=89, a_hi=0.7, a_lo=0.05){
  showtext_auto() 
  
  grid_col = gen_grid_color(mat, colorMajor)
  circos.par(start.degree = my_degree, clock.wise = FALSE)
  chordDiagram(mat, grid.col = grid_col, 
               row.col = colorHL(n,colorMajor, a_hi, a_lo), 
               annotationTrack = c("name","grid"))
  abline(v = 0, lty = 2, col = "#00000080")
  circos.clear()
  
}

save_to_pdf <- function(plot_obj, name="tmp.pdf", my_width=7, my_height=7, font_size=1.5){
  pdf(name, width=7, height=7,onefile=T)
  par(cex = font_size, mar = c(0, 0, 0, 0))
  print(plot_obj)
  dev.off()
}



mat = gen_mat(test_data)
colorMajor = c('red', 'green', 'blue', 'yellow', 'purple')
plot_hi_chord(mat, 2)
save_to_pdf(plot_hi_chord(mat,3))

colorHL(2, colorMajor)
