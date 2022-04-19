db.name <- getMtcarsdbPath(copy = TRUE)
ElectionsLATAM <- createElectionsLATAM(drv = ElectionsLATAMite::SQLite(), dbname = db.name)

where_values_df <- data.frame(carb = 8, stringsAsFactors = FALSE)
select_sql <- ElectionsLATAM$gen_select(
  select_fields = "*", # c("wt", "qsec"),
  table = "mtcars",
  where_values = where_values_df
)
mtcars.observed <- ElectionsLATAM$execute_select(select_sql)
mtcars.observed
mtcars.new <- mtcars.observed
mtcars.new$carb <- 9
insert_sql <- ElectionsLATAM$gen_insert(table = "mtcars", values_df = mtcars.new)
ElectionsLATAM$execute_insert(sql_insert = insert_sql)

where_values_df <- data.frame(carb = 9, stringsAsFactors = FALSE)
select_sql <- ElectionsLATAM$gen_select(
  select_fields = "*", # c("wt", "qsec"),
  table = "mtcars",
  where_values = where_values_df
)
mtcars.observed <- ElectionsLATAM$execute_select(select_sql)
mtcars.observed
