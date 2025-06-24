# mtcars-Explorer

A minimal Shiny dashboard for interactively exploring the built-in `mtcars` dataset.

## Prerequisites

- R ≥ 4.0  
- The following packages (install via `install.packages()`):

  ```r
  install.packages(c("shiny", "ggplot2", "DT"))
  ```

## Running the App

In an R console:

```r
# set your working directory to the project folder, then:
library(shiny)
runApp("app.R")
```

Or from command line:

```bash
R -e "shiny::runApp('app.R')"
```

---

## Features

- **MPG slider**: filter cars by miles-per-gallon range.  
- **Cylinders chooser**: select one or more cylinder groups (4, 6, 8).  
- **Scatter plot** of Horsepower vs. MPG, colored by cylinders.  
- **Data table** showing the top 10 rows of your filtered subset.
