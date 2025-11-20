library(ghclass)
library(tidyverse)

# Set organization
org <- "sta221-fa25"

# Set assignment name
task = "project-"

# Read in teams sheet
df <- readxl::read_xlsx("~/Downloads/teams_221.xlsx")

team_names = df %>%
  distinct(team) %>%
  pull()

# Randomly assign peer reviews
set.seed(221)
total = 1
iters = 0
while(total > 0 & iters < 100) {
team1 = sample(team_names, replace = FALSE)
total = sum(team_names == team1)
iters = iters + 1
if(iters == 100) {
  stop("Did not sample a team assignment without match")
}
}
total = 1
iters = 0
while(total > 0 & iters < 100) {
  team2 = sample(team_names, replace = FALSE)
  total = sum(team_names == team2) + sum(team1 == team2)
  iters = iters + 1
  if(iters == 100) {
    stop("Did not sample a team assignment without match")
  }
}

df2 = data.frame(group = team_names,
                 review1 = team1,
                 review2 = team2)

## Sanity check

### Does any team review itself?
if(sum(df2$group == df2$review1) > 0 | sum(df2$group == df2$review2) > 0) {
  stop("TEAM IS REVIEWING ITSELF")
} else {
  ("Passed check 1: no team reviews itself.")
}
### Does any team review the same team twice?
if(sum(df2$review1 == df2$review2) > 0) {
  stop("TEAM IS REVIEWING ITSELF")
} else {
  ("Passed check 2: no team reviews the same team twice")
}

## make columns the repos
df3 = df2 %>%
  mutate(review1 = paste0(task, review1),
         review2 = paste0(task, review2))


# Function to grant read access from one team to one repo
grant_read_access <- function(team, repo) {
  message("Granting read access: team = ", team, "  repo = ", repo)
  # permission = "pull" means read-only
  
  ## Debugging:
  ## print(paste0(org, "/", repo))
  
  try(ghclass::repo_add_team(
    team       = team,    # team name
    repo       = paste0(org, "/", repo),
    permission = "pull"   # read-only
  )
  )
}

for(i in 1:nrow(df3)) {
  grant_read_access(df3$group[i], df3$review1[i])
  grant_read_access(df3$group[i], df3$review2[i])
}

write_csv(df3, "~/Downloads/sta221-fa25-peer-review.csv")

