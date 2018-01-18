# Libraries
require(rgdal)
require(raster)
library(gdalUtils)
library(parallel)
rasterOptions(tmpdir="~/temp")

rawfolders <- list.files("~/MODIS_ARC/rawdata", full.names = T)
outfolders <- list.files("~/MODIS_ARC/PROCESSED", full.names = T)
coor <- read.csv("~/MODIS_ARC/coordenadas_tiles.csv")

# define output projection

oldproj <- "+proj=sinu +lon_0=0 +x_0=0 +y_0=0 +a=6371007.181 +b=6371007.181 +units=m +no_defs"
newproj <- "+proj=utm +zone=19 +south +ellps=WGS84 +units=m +no_defs"

for (j in 1:length(rawfolders)){
  infiles <- list.files(path=rawfolders[j], pattern=glob2rx("*.hdf"), full.names=T)
  sceneID <- substr(infiles, 42,57)
  outfiles <- paste(outfolders[j], '/', sceneID, '.tiff', sep='')
  setwd(outfolders)
  ext <- c(coor$xmin[j], coor$xmax[j], coor$ymax[j], coor$ymin[j])
  
  for (i in 1:length(infiles)) {
    gdal_translate(infiles[i], 'b1.tif', sd_index=1, overwrite=T)
    gdalwarp("b1.tif","b1_UTMWGS84.tif",s_srs=oldproj,
             t_srs=newproj, te=ext, tr=c(250,250),
             overwrite=T)
    
    gdal_translate(infiles[i], 'b2.tif', sd_index=2, overwrite=T)
    gdalwarp("b2.tif","b2_UTMWGS84.tif",s_srs=oldproj,
             t_srs=newproj, te=ext,tr=c(250,250),
             overwrite=T)
    
    gdal_translate(infiles[i], 'b3.tif', sd_index=3, overwrite=T)
    gdalwarp("b3.tif","b3_UTMWGS84.tif",s_srs=oldproj,
             t_srs=newproj, te=ext,tr=c(250,250),
             overwrite=T)
    
    gdal_translate(infiles[i], 'b12.tif', sd_index=12, overwrite=T)
    gdalwarp("b12.tif","b12_UTMWGS84.tif",s_srs=oldproj,
             t_srs=newproj, te=ext,tr=c(250,250),
             overwrite=T)
    
    st<-stack("b1_UTMWGS84.tif","b2_UTMWGS84.tif","b3_UTMWGS84.tif","b12_UTMWGS84.tif")
    writeRaster(st, filename=outfiles[i], format='GTiff', overwrite=T)
    cat("Scene # ", i, " stack bands 1,2,3,12 COMPLETED.\n", sep="")  
  }
  
  
}

