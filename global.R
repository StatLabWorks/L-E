library(shiny)
library(shinydashboard)
library(data.table)
library(ggplot2)
library(plotly)
library(lubridate)
library(hrbrthemes)

# make the data ready


# målinger c(dato, vægt, længde, hovedomfang)
lauge <- rbind(
  data.table(dato = ymd("2014-05-07"), vaegt = 4.45, laengde = 53, hovede = 36),
  data.table(dato = ymd("2014-05-12"), vaegt = 4.2, laengde = NA, hovede = NA),
  data.table(dato = ymd("2014-05-19"), vaegt = 4.55, laengde = 55, hovede = 38),
  data.table(dato = ymd("2014-06-10"), vaegt = 5.75, laengde = 60, hovede = 40),
  data.table(dato = ymd("2014-08-11"), vaegt = 7.65, laengde = 68.5, hovede = 42.5),
  data.table(dato = ymd("2014-09-08"), vaegt = 8.32, laengde = 70, hovede = 43.5),
  data.table(dato = ymd("2014-10-09"), vaegt = 9.2, laengde = 70, hovede = 45),
  data.table(dato = ymd("2014-11-17"), vaegt = 9.52, laengde = 71.6, hovede = 45.3),
  data.table(dato = ymd("2015-02-18"), vaegt = 10.52, laengde = 73.5, hovede = 47.2),
  data.table(dato = ymd("2015-05-12"), vaegt = 11.8, laengde = 79, hovede = 48),
  data.table(dato = ymd("2016-04-26"), vaegt = 15.1, laengde = 87, hovede = 50),
  data.table(dato = ymd("2017-06-12"), vaegt = 16.9, laengde = 99, hovede = 53),
  data.table(dato = ymd("2018-06-19"), vaegt = 18.9, laengde = 108, hovede = 54),
  data.table(dato = ymd("2019-05-31"), vaegt = 20.8, laengde = 114.6, hovede = NA)
)

lauge[, navn := "Lauge"][, foedselsdag := ymd("2014-05-07")]
lauge[, alder := dato - foedselsdag]
lauge[, alder := time_length(difftime(dato, foedselsdag), "years")]

emil <- rbind(
  data.table(dato = ymd("2017-09-10"), vaegt = 4.632, laengde = 55, hovede = 37),
  data.table(dato = ymd("2017-09-15"), vaegt = 4.72, laengde = NA, hovede = 37),
  data.table(dato = ymd("2017-09-21"), vaegt = 4.9, laengde = 56.5, hovede = 37),
  data.table(dato = ymd("2017-10-25"), vaegt = 6.25, laengde = 59, hovede = 40),
  data.table(dato = ymd("2017-11-22"), vaegt = 7.16, laengde = 66.8, hovede = 41),
  data.table(dato = ymd("2017-12-18"), vaegt = 7.58, laengde = NA, hovede = NA),
  data.table(dato = ymd("2018-02-22"), vaegt = 9.15, laengde = 68, hovede = 44),
  data.table(dato = ymd("2018-06-20"), vaegt = 11.2, laengde = 74, hovede = 47),
  data.table(dato = ymd("2018-08-30"), vaegt = 11.4, laengde = 77, hovede = 48),
  data.table(dato = ymd("2019-09-13"), vaegt = 15.0, laengde = 91, hovede = 50),
  data.table(dato = ymd("2020-08-26"), vaegt = 16.6, laengde = 102, hovede = 52)
)

emil[, navn := "Emil"][, foedselsdag := ymd("2017-09-10")]
emil[, alder := time_length(difftime(dato, foedselsdag), "years")]

dat <- rbind(emil, lauge)

StatLab_colors <- c(
  `dark grey` = "#64555C",
  `clay` = "#B7A9A6",
  `blue` = "#2D8C9B",
  `green` = "#9AD2AD",
  `yellow` = "#FCB550",
  `pink` = "#E05C90",
  `light pink` = "#F49DA8")

cols <- c("Emil" = as.character(StatLab_colors["blue"]), "Lauge" = as.character(StatLab_colors["clay"]))
