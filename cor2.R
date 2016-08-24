
# ajuste su directorio de trabajo
setwd('~/Bioclimas');

# ajuste las varaibles que requiere

variables = c(paste('bio',0,1:9,sep=""),paste('bio',10:19,sep=""));

i = 1;

while (i <= length(variables)) {
	# elimina las primeras lineas de texto del ascii
	values = scan(file=paste(variables[i],'.asc',sep=""),skip=6);
	
	values[values == -9999] = NA;

	if (i == 1) {
		df = data.frame(values);
	} else {
		df = data.frame(df,values);
	}

	i = i + 1;
}
# nombrar las columnas con el nombre de los bioclimas
names(df) = variables;

corr.matrix = cor(df,use='complete.obs');

write.csv(corr.mtrx,file="corr.matrix.csv",quote=FALSE)

# Plot de las correlaciones

library(corrplot)
corr.plot <- cor(corr.matrix)
corrplot(corr.plot, method="circle")
