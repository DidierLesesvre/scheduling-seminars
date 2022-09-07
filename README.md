Scheduling MiniZinc model to assign students to courses

- scheduling-modules.mzn is the MiniZinc model
- data<n>.mzn are example data files

# Purpose

This MiniZinc model gives an optimal schedule with the following data:

- n students
- m topics
- the students rank preferences for topics

The minimization is essentially on a sum of preferences to a certain power, to rule out pretty quickly low preferences. 
  
The output is :
  
- each line correspond to a student
- the first list contains the assigned topics
- the second list constains the corresponding group/instance/time slot
- the last list contains the corresponding preferences (to have a feeling on how tolerable is the result)
- the sizes of the groups and timeslots assignments are displayed at the end
  
An efficient solver to use this model is coin-bc.

# In practice: from a spreadsheet containing the list of students and preferences

## Base file

Start with a .xls containing the list of students with their preferences

Open it with LibreOffice

## Exporting from xls to csv and formating

Add a column of xxx to the right of the names

Add a column of xxx to the right of the preferences

Replace empty cells by a certain value (e.g. the maximum of the preferences) by ctrl+H (find/replace), ticking "regular expression", Find : "^$" and replace by "maxvalue"

Export the name part (with xxx) in .csv, separating with commas (,) and turning into strings with quotes (")

Export the preferences (with xxx) in .csv, separating with commas (,)

## Data files

Open them with file editors

Replace ",xxx" by "|"

Control the ends [| and |];

Input them in data files .dzn as "name" and "preference"

## Run the models

Both in MiniZinc, with the coin-bc solver
