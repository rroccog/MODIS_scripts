# -----------------------------------------------------------

# Merge MODIS scenes CHILE (NA outside Chile land territory)

# Author: R.O. Chávez
# Las updated: 02-03-2015

# -----------------------------------------------------------

# Libraries

require(rgdal)
require(raster)
library(gdalUtils)
library(maptools)
library(parallel)

tempfiles <- '~/temp'
rasterOptions(tmpdir=tempfiles)

# -----------------------------------------------------------

# Inputs, outputs

inpaths <- list.files("~/MODIS_ARC/PROCESSED", full.names = T)
dirs <- list.files("~/MODIS_ARC/PROCESSED", full.names = F)

for (i in 1:length(inpaths)){
  hv <- dirs[i]
  assign(hv, list.files(inpaths[i],full.names = T))
}

ID_h11v10 <- substr(h11v10,41,56)
ID_h11v11 <- substr(h11v11,41,56)
ID_h11v12 <- substr(h11v12,41,56)
ID_h12v12 <- substr(h12v12,41,56)
ID_h12v13 <- substr(h12v13,41,56)
ID_h13v13 <- substr(h13v13,41,56)
ID_h13v14 <- substr(h13v14,41,56)
ID_h14v14 <- substr(h14v14,41,56)

outpath <- "~/MODIS_ARC/PROCESSED"
outfiles <- paste(outpath, '/', 'CHILE_', ID_h11v10, ".v6",'.tiff', sep='')
#mask.poly <- readShapePoly('~/02_user_roberto/01_noth_chile/shape/Chile_border_UTMWGS84_H19S.shp')

# -----------------------------------------------------------

# loop for all scenes

for (i in 1:length(h11v10)) {
  
  if(ID_h11v10[i]==ID_h11v11[i] & ID_h11v11[i]==ID_h11v12[i] & ID_h11v12[i]==ID_h12v12[i] & ID_h12v12[i]==ID_h12v13[i] & ID_h12v13[i]==ID_h13v13[i] & ID_h13v13[i]==ID_h13v14[i] & ID_h13v14[i]==ID_h14v14[i]) {
    
    r01.b01 <- raster(h11v10[i], band=1)
    r01.b02 <- raster(h11v10[i], band=2)
    r01.b03 <- raster(h11v10[i], band=3)
    r01.b12 <- raster(h11v10[i], band=4)
    
    r02.b01 <- raster(h11v11[i], band=1)
    r02.b02 <- raster(h11v11[i], band=2)
    r02.b03 <- raster(h11v11[i], band=3)
    r02.b12 <- raster(h11v11[i], band=4)
    
    r03.b01 <- raster(h11v12[i], band=1)
    r03.b02 <- raster(h11v12[i], band=2)
    r03.b03 <- raster(h11v12[i], band=3)
    r03.b12 <- raster(h11v12[i], band=4)
    
    r04.b01 <- raster(h12v12[i], band=1)
    r04.b02 <- raster(h12v12[i], band=2)
    r04.b03 <- raster(h12v12[i], band=3)
    r04.b12 <- raster(h12v12[i], band=4)
    
    r05.b01 <- raster(h12v13[i], band=1)
    r05.b02 <- raster(h12v13[i], band=2)
    r05.b03 <- raster(h12v13[i], band=3)
    r05.b12 <- raster(h12v13[i], band=4)
    
    r06.b01 <- raster(h13v13[i], band=1)
    r06.b02 <- raster(h13v13[i], band=2)
    r06.b03 <- raster(h13v13[i], band=3)
    r06.b12 <- raster(h13v13[i], band=4)
    
    r07.b01 <- raster(h13v14[i], band=1)
    r07.b02 <- raster(h13v14[i], band=2)
    r07.b03 <- raster(h13v14[i], band=3)
    r07.b12 <- raster(h13v14[i], band=4)
    
    r08.b01 <- raster(h14v14[i], band=1)
    r08.b02 <- raster(h14v14[i], band=2)
    r08.b03 <- raster(h14v14[i], band=3)
    r08.b12 <- raster(h14v14[i], band=4)
    
    rm.b01 <- merge(r01.b01,r02.b01,r03.b01,r04.b01,r05.b01,r06.b01,r07.b01,r08.b01)
    rm.b02 <- merge(r01.b02,r02.b02,r03.b02,r04.b02,r05.b02,r06.b02,r07.b02,r08.b02)
    rm.b03 <- merge(r01.b03,r02.b03,r03.b03,r04.b03,r05.b03,r06.b03,r07.b03,r08.b03)
    rm.b12 <- merge(r01.b12,r02.b12,r03.b12,r04.b12,r05.b12,r06.b12,r07.b12,r08.b12)
    
    clmask <-raster("~/MODIS_ARC/MODIS_Rscript/MODIS_mask_Chile.tif")
    
    rm.b01[clmask==9999] <- NA
    rm.b02[clmask==9999] <- NA
    rm.b03[clmask==9999] <- NA
    rm.b12[clmask==9999] <- NA
    
    st<-stack(rm.b01,rm.b02,rm.b03,rm.b12)
    writeRaster(st, filename=outfiles[i], format='GTiff', overwrite=T)
    
    cat("Scene # ", i, " MERGED.\n", sep="")
    
    temp_list <- list.files(tempfiles, full.names = T)
    file.remove(temp_list) 
    
  } else {
    cat("ERROR Scene # ", i, " has different MODIS ID.\n", sep="")
  }
}
