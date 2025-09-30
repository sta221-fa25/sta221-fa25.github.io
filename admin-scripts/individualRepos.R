# initial assignment creation
library(ghclass)
library(tidyverse)
org = "sta221-fa25"
usernames = ghclass::org_members(org)
usernames = sort(usernames)
# n = 0
# u2 = usernames[-(1:n)]

## edit this:
assignment_template_repo = "lab-04"

ghclass::org_create_assignment(
  org = org,
  repo = paste0(assignment_template_repo, "-", usernames),
  user = usernames,
  source_repo = paste0(org, "/", assignment_template_repo)
)