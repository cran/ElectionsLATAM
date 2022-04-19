library(ElectionsLATAM)
library(readr)
france.ein.path <- "~/.R/ElectionsLATAM/ein/france/"
ecological.inference.calvo <- EcologicalInferenceStrategyCalvoEtAl$new()
france.ein <-
  EcologicalInferenceProcessor$new(
    ecological.inference.strategy = ecological.inference.calvo,
    election.name = "2017-2022-france",
    scenario = "final",
    data.input.path = france.ein.path,
    input.file = "2017-primeraVuelta-pivot.csv",
    location.fields = c("id_unidad"),
    votes.field = "votantes",
    # potential.votes.field = "electores",
    ignore.fields = "electores",
    col.types = cols(
      .default = col_number(),
      id_unidad = col_character()
    )
  )
dummy <- france.ein$loadInputPivotCandidatos()
france.ein$output.election <- readr::read_delim(
  # ballotage.processor$pivot.filepath,
  file.path(
    france.ein.path,
    paste("2022-primeraVuelta-pivot.csv", sep = "_")
  ),
  delim = ";",
  col_types = cols(
    .default = col_double(),
    id_unidad = col_character()
  )
)

france.ein$runScenario(
  include.blancos = TRUE, include.ausentes = TRUE,
  max.potential.votes.rel.dif = 0.2
)

# france.ein$potential.votes.check %>% filter(abs(potential.votes.rel.diff) > 0.2)

# hist(france.ein$potential.votes.check$potential.votes.rel.diff)
kable(head(france.ein$potential.votes.check, n = 10))

france.test.path <- file.path(tempdir(), "test", "france")
france.ein$exportBetab(output.folder = france.test.path, overwrite = TRUE)
dummy <- france.ein$generateOutputJSON(france.test.path,
  filename = "general_2017_general_2022_ei_20.json"
)
france.ein$makeSankeyDiagram(output.path = france.test.path)

# Saving output table for reproducibility
#  write_rds(france.ein$output.table, file.path(france.ein.path, "ein_2021_general_2022_ballotage.rds"))


ecological.inference.calvo <- EcologicalInferenceStrategyCalvoEtAl$new()
france.ein <-
  EcologicalInferenceProcessor$new(
    ecological.inference.strategy = ecological.inference.calvo,
    election.name = "2017-2022-france",
    scenario = "final",
    data.input.path = france.ein.path,
    input.file = "2017-primeraVuelta-pivot-todos.csv",
    location.fields = c("id_unidad"),
    votes.field = "votantes",
    # potential.votes.field = "electores",
    ignore.fields = "habilitados",
    col.types = cols(
      .default = col_number(),
      id_unidad = col_character()
    )
  )
dummy <- france.ein$loadInputPivotCandidatos()
problems(france.ein$input.election)

length(strsplit("ZZ-229;105;27;87;18;205;2893;567;41;622;4672;1050;61;10348;21477", split = ";")[[1]])
length(strsplit("ZZ-231;9;1;35;3;8;113;47;6;45;260;156;2;685;vc", split = ";")[[1]])

france.ein$output.election <- readr::read_delim(
  # ballotage.processor$pivot.filepath,
  file.path(
    france.ein.path,
    paste("2022-primeraVuelta-pivot-todos.csv", sep = "_")
  ),
  delim = ";",
  col_types = cols(
    .default = col_double(),
    id_unidad = col_character()
  )
)

france.ein$runScenario(
  include.blancos = TRUE, include.ausentes = TRUE,
  max.potential.votes.rel.dif = 0.2
)

# france.ein$potential.votes.check %>% filter(abs(potential.votes.rel.diff) > 0.2)

# hist(france.ein$potential.votes.check$potential.votes.rel.diff)
kable(head(france.ein$potential.votes.check, n = 10))

# france.test.path <- file.path(tempdir(), "test","france")
france.test.path <- file.path(france.ein.path, "..", "results")
france.ein$exportBetab(output.folder = france.test.path, overwrite = TRUE)
dummy <- france.ein$generateOutputJSON(france.test.path,
  filename = "general_2017_general_2022_ei_todos_20.json"
)
france.ein$makeSankeyDiagram(output.path = france.test.path)
