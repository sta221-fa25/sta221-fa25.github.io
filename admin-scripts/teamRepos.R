library(tidyverse)
library(ghclass)


## Make teams (once)

all_team <- readxl::read_xlsx("~/Downloads/teams_221_project.xlsx")

team_names <- all_team %>%
  select(team) %>%
  pull()

org <- "sta221-fa25"

# create teams
team_create(org, team_names)

# invite to teams
for(team_name in team_names) {
  users = all_team %>%
    filter(team == team_name) %>%
    select(github) %>%
    pull()
  
  team_invite(org, user = users, team = team_name)
}


###########################
#### deploy team repos ####
###########################

all_team <- readxl::read_xlsx("~/Downloads/teams_221_project.xlsx")

# example data frame for demo purposes
# you will need to format your data frame to look like this
roster = all_team

# edit each item below
org_create_assignment(
  org = "sta221-fa25",
  user = roster$github,
  repo = paste0("lab-06-", roster$team), ## edit this
  team = roster$team,
  source_repo = "sta221-fa25/lab-06", ## edit this
  private = TRUE
)
