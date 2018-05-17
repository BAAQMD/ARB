#
# To create a subdirectory if doesn't already exist.
# And to return the "subdirectory" part of a given path.
#
subdir <- function (..., create = TRUE) {
  path <- file.path(...)
  if (!file.exists(path) && create) {
    dir.create(path, recursive = TRUE)
  }
  normalized <- normalizePath(path, mustWork = TRUE)
  return(normalized)
}


unzipped <- function (zip_file, pattern = ".*", ...) {

  tmp_dn <- tempdir()
  file_set <- unzip(zip_file, list = TRUE)
  file_names <- file_set[["Name"]]
  exdir <- subdir(tmp_dn, basename(zip_file)) # see above for definition of `subdir()`
  unzip(zip_file, files = str_detect(file_names, pattern), exdir = exdir, ...)
  return(tmp_dn)

}

