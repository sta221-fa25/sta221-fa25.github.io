# edit paths:
# grades <- readxl::read_xlsx("~/Downloads/STA221_Grades_Fall2025(1).xlsx")


grades |>
  select(Student, ID, `SIS User ID`, `SIS Login ID`, Section,
         quiz01, quiz02) |> # edit assignments 
  write_csv(paste0("~/Downloads/upload-", Sys.Date(), ".csv"))
