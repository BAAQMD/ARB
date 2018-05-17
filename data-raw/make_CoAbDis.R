make_ARB_CoAbDis <- function (zip_file, layer = "CoAbDis", tmpdn = tempdir()) {

  message("unzipping ", zip_file, " into ", tmpdn)

  dsn <-
    normalizePath(tmpdn)

  unzipped_filenames <-
    unzip(zip_file, exdir = dsn, junkpaths = TRUE)

  if (is.null(layer)) {
    layer <-
      unzipped_filenames %>%
      map_chr(basename) %>%
      keep(str_detect, pattern = "shp$") %>%
      tools::file_path_sans_ext() %>%
      first()
  }

  sf_obj <-
    read_sf(dsn = dsn, layer = layer) %>%
    st_transform(st_crs(26910)) # NAD83 UTM10

  return(sf_obj)

}

download_ARB_CoAbDis <- function (...) {

  download.file(
    url = "https://www.arb.ca.gov/ei/gislib/boundaries/ca_co_ab_dis.zip",
    ...)

}
