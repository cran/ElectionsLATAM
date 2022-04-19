# install.packages("pkgnet")
library(pkgnet)
report2 <- CreatePackageReport(
  pkg_name = "ElectionsLATAM"
  # , pkg_path = <path to the repo>
)


all.packages <- available.packages()
ElectionsLATAM.package <- all.packages[grep("^ElectionsLATAM$", all.packages[, 1]), ]
package_dependencies(ElectionsLATAM.package)

library(remotes)

remotes::package_deps("ElectionsLATAM")
