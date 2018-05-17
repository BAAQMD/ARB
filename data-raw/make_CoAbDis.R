make_ARB_CoAbDis <- function (zip_file, layer = "CoAbDis", tmpdn = tempdir()) {

  require(shptools) # for `read_shp()`

  imported <-
    read_shp(dsn = dsn, layer = layer, verbose = TRUE)

  reprojected <-
    imported %>%
    st_transform(st_crs(26910)) # NAD83 UTM10

  tidied <-
    reprojected %>%
    mutate_at(vars(COABDIS_AR), funs(as.character)) %>%
    mutate_at(vars(ends_with("_ID")), funs(as.integer))

  return(tidied)

}

download_ARB_CoAbDis <- function (...) {

  download.file(
    url = "https://www.arb.ca.gov/ei/gislib/boundaries/ca_co_ab_dis.zip",
    ...)

}
