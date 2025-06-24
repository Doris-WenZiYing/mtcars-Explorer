# app.R
library(shiny)
library(ggplot2)
library(DT)

# UI
ui <- fluidPage(
  titlePanel("mtcars Explorer"),

  sidebarLayout(
    sidebarPanel(
      sliderInput(
        inputId = "mpg_range",
        label   = "Miles per Gallon (MPG):",
        min     = min(mtcars$mpg),
        max     = max(mtcars$mpg),
        value   = c(min(mtcars$mpg), max(mtcars$mpg))
      ),
      checkboxGroupInput(
        inputId = "cyl_filter",
        label   = "Cylinders:",
        choices = sort(unique(mtcars$cyl)),
        selected = unique(mtcars$cyl)
      )
    ),

    mainPanel(
      tabsetPanel(
        tabPanel("Plot", plotOutput("hp_mpg_plot")),
        tabPanel("Table", DTOutput("filtered_table"))
      )
    )
  )
)

# Server
server <- function(input, output, session) {

  # Reactive filtered dataset
  filtered_data <- reactive({
    req(input$cyl_filter)
    subset(
      mtcars,
      mpg >= input$mpg_range[1] &
      mpg <= input$mpg_range[2] &
      cyl %in% input$cyl_filter
    )
  })

  # Scatter plot of HP vs MPG
  output$hp_mpg_plot <- renderPlot({
    df <- filtered_data()
    ggplot(df, aes(x = hp, y = mpg, color = factor(cyl))) +
      geom_point(size = 3) +
      labs(
        x = "Horsepower (hp)",
        y = "Miles Per Gallon (mpg)",
        color = "Cylinders"
      ) +
      theme_minimal()
  })

  # Data table (top 10 rows)
  output$filtered_table <- renderDT({
    df <- filtered_data()
    datatable(
      head(df, 10),
      options = list(pageLength = 10, searching = FALSE)
    )
  })
}

# Run the app
shinyApp(ui, server)
