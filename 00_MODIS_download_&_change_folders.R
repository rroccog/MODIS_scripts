library(MODIS)

# Download MODIS

getHdf(product = "MOD13Q1", begin = "2017113", end = "2017177", tileH = 11, tileV = 10)
getHdf(product = "MOD13Q1", begin = "2017113", end = "2017177", tileH = 11, tileV = 11)
getHdf(product = "MOD13Q1", begin = "2017113", end = "2017177", tileH = 11, tileV = 12)
getHdf(product = "MOD13Q1", begin = "2017113", end = "2017177", tileH = 12, tileV = 12)
getHdf(product = "MOD13Q1", begin = "2017113", end = "2017177", tileH = 12, tileV = 13)
getHdf(product = "MOD13Q1", begin = "2017113", end = "2017177", tileH = 13, tileV = 13)
getHdf(product = "MOD13Q1", begin = "2017113", end = "2017177", tileH = 13, tileV = 14)
getHdf(product = "MOD13Q1", begin = "2017113", end = "2017177", tileH = 14, tileV = 14)

# Change folders

folders <- list.files("/media/alerce/ROBERTO/IMAGERY/MODIS/Originals/MYD13Q1.006", full.names = T)

files_h11v10 <- list.files("/media/alerce/ROBERTO/IMAGERY/MODIS/Originals/MYD13Q1.006", pattern = glob2rx("*h11v10*"), full.names = T, recursive = T)
files_h11v11 <- list.files("/media/alerce/ROBERTO/IMAGERY/MODIS/Originals/MYD13Q1.006", pattern = glob2rx("*h11v11*"), full.names = T, recursive = T)
files_h11v12 <- list.files("/media/alerce/ROBERTO/IMAGERY/MODIS/Originals/MYD13Q1.006", pattern = glob2rx("*h11v12*"), full.names = T, recursive = T)
files_h12v12 <- list.files("/media/alerce/ROBERTO/IMAGERY/MODIS/Originals/MYD13Q1.006", pattern = glob2rx("*h12v12*"), full.names = T, recursive = T)
files_h12v13 <- list.files("/media/alerce/ROBERTO/IMAGERY/MODIS/Originals/MYD13Q1.006", pattern = glob2rx("*h12v13*"), full.names = T, recursive = T)
files_h13v13 <- list.files("/media/alerce/ROBERTO/IMAGERY/MODIS/Originals/MYD13Q1.006", pattern = glob2rx("*h13v13*"), full.names = T, recursive = T)
files_h13v14 <- list.files("/media/alerce/ROBERTO/IMAGERY/MODIS/Originals/MYD13Q1.006", pattern = glob2rx("*h13v14*"), full.names = T, recursive = T)
files_h14v14 <- list.files("/media/alerce/ROBERTO/IMAGERY/MODIS/Originals/MYD13Q1.006", pattern = glob2rx("*h14v14*"), full.names = T, recursive = T)

names <- substr(files_h11v10, 70, 86)

out.names_h11v10 <- paste(folders[1], "/", names, "h11v10.v6.", "hdf", sep = "")
out.names_h11v11 <- paste(folders[2], "/", names, "h11v11.v6.", "hdf", sep = "")
out.names_h11v12 <- paste(folders[3], "/", names, "h11v12.v6.", "hdf", sep = "")
out.names_h12v12 <- paste(folders[4], "/", names, "h12v12.v6.", "hdf", sep = "")
out.names_h12v13 <- paste(folders[5], "/", names, "h12v13.v6.", "hdf", sep = "")
out.names_h13v13 <- paste(folders[6], "/", names, "h13v13.v6.", "hdf", sep = "")
out.names_h13v14 <- paste(folders[7], "/", names, "h13v14.v6.", "hdf", sep = "")
out.names_h14v14 <- paste(folders[8], "/", names, "h14v14.v6.", "hdf", sep = "")

file.rename(files_h11v10, out.names_h11v10)
file.rename(files_h11v11, out.names_h11v11)
file.rename(files_h11v12, out.names_h11v12)
file.rename(files_h12v12, out.names_h12v12)
file.rename(files_h12v13, out.names_h12v13)
file.rename(files_h13v13, out.names_h13v13)
file.rename(files_h13v14, out.names_h13v14)
file.rename(files_h14v14, out.names_h14v14)
