gen_mat <- function(df){
  
  mat = as.matrix(df[-1]) 
  rownames(mat) = as.vector(unlist(df[,1]))
  
  mat 
}

make_color_table <- function(df, name){
  
  color_table = read_csv(paste0(workinghome, name), col_names=T)
  columns = as.vector(unlist(df[,1]))
  rows = colnames(df)[-1]
  
  tdf = data.frame(expand.grid(columns, rows))
  names(tdf) <- c('major', 'occ')
  
  tdf %>% left_join(color_table, by = c("major"))
  
}

gen_major_alphacolor <- function(df, major_c, alpha_h=0.75, alpha_l=0.1){
  
  df %>% mutate(
    col_alpha = if_else(major %in% major_c, 
                        adjustcolor(color, alpha.f = alpha_h), adjustcolor(color, alpha.f = alpha_l))
  )
}

gen_occ_alphacolor <- function(df, occ_c, alpha_h=0.75, alpha_l=0.1){
  
  df %>% mutate(
    col_alpha = if_else(occ %in% occ_c, 
                        adjustcolor(color, alpha.f = alpha_h), adjustcolor(color, alpha.f = alpha_l))
  )
}

gen_oneside_hl <- function(df, elements, alpha_h=0.75, alpha_l=0.1, name="color_selection.csv"){
  
  cdf1 <- make_color_table(df, "color_selection.csv")
  
  if (elements[1] %in% unique(cdf1$major)) {
    gen_major_alphacolor(cdf1, elements, alpha_h, alpha_l)
  } else {
    gen_occ_alphacolor(cdf1, elements, alpha_h, alpha_l)
  }
  
}

gen_grid_color <- function(mat, colorM){
  
  ncol = length(mat[1,])
  colorO = rep('grey',ncol) 
  grid.col = c(colorM, colorO)
  names(grid.col) = c(row.names(mat), colnames(mat))
  
  grid.col  
}

plot_hichord <- function(mat, ctable, my_degree=89){
  showtext_auto() 
  
  colorgrid = unique(ctable$color)
  grid_col = gen_grid_color(mat, colorgrid)
  ctable = ctable %>% select('major', 'occ', 'col_alpha')
  circos.par(start.degree = my_degree, clock.wise = FALSE)
  chordDiagram(mat, grid.col = grid_col, 
               #row.col = colorAlpha(colorMajor, a),
               col = ctable,
               annotationTrack = c("name","grid"))
  abline(v = 0, lty = 2, col = "#00000080")
  mtext("Test", outer=T)
  circos.clear()
  
}

save_to_pdf <- function(plot_obj, name="tmp.pdf", my_width=7, my_height=7, font_size=1.5){
  pdf(name, width=7, height=7, onefile=T)
  par(cex = font_size, mar = c(0, 0, 0, 0))
  print(plot_obj)
  dev.off()
}

wrap_oneside_chord <- function(name, elements, alpha_h=0.9, alpha_l=0.08, save_pdf=F, label_size=1.5){
  
  df = read_csv(paste0(workinghome,name))
  mat = gen_mat(df)
  color_df <- gen_oneside_hl(df, elements, alpha_h, alpha_l)
  #pl = plot_hichord(mat, color_df)
  
  if (save_pdf==F){
    plot_hichord(mat, color_df)
  } else {
    plot_hichord(mat, color_df)
    name_pdf = paste0("cplot-", paste0(elements, collapse="_"),".pdf")
    save_to_pdf(plot_hichord(mat, color_df),name_pdf, font_size=label_size)
  }
  
}
