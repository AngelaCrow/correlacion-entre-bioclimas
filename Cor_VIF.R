install.packages("fuzzySim", repos = "http://R-Forge.R-project.org")
library(raster)
library(fuzzySim)
library(dismo)
library(magrittr)

# ajuste su directorio de trabajo
setwd('')

# Background, como quieres hacerlo entre las variables hay que generar puntos al azar
env<-stack(list.files("Variables/", pattern = ".tif$*", full.names = T))
bg.df <- dismo::randomPoints(env[[1]], n = 10000) %>% as.data.frame()

covarData <- raster::extract(env, bg.df)
covarData <- cbind(bg.df, covarData)

# analizar las correlaciones (multicolinealidad) entre variables y el factor de inflaccion:
?multicol
multicol(covarData[ , 3:ncol(covarData)])  # especificar solo las columnas con variables!
# min 18:42 https://www.youtube.com/watch?v=uo0kgxOd_fM&t=1574s&list=PLu_3tLNPCPDZ7KhT5WzapXG5VuqQz7RT3&index=4

####SELECCION DE VARIABLES####
correlacion <- corSelect(
  data = covarData, 
  sp.cols = 27,
  var.cols = 3:ncol(covarData), 
  cor.thresh = 0.8, 
  use = "pairwise.complete.obs")

correlacion

select_var <- correlacion$selected.vars %>% as.data.frame()
write.csv(select_var, "cor_select_var.csv")

