server <- function(input, output, session) {
  
  values <- reactiveValues()
  values$login <- F
  
  # log in functionality
  
  observeEvent(input$login, {
    
    req(input$username)
    req(input$pwd)
    
    cat("here # 1")
        
    if (input$username == "anders" & input$pwd == "anders") values$login <- T
    if (input$username == "malle" & input$pwd == "malle") values$login <- T
    
    output$logInStatus <- renderUI({
      if (values$login) {
        HTML("<i>Log-in successful</i>")
      } else {
        HTML("<p style='color:darkred'><i>incorrect username or password<(i>")
      }  
    })
    
  })
  
  observe({
    
    output$statusMessage <- renderUI({
      
      if (values$login) {
        NULL
      } else {
        HTML("You don't have access to view these data")
      }
         
    })
  })
  
  observe({
    output$selectMeasure <- renderUI({
      
      if (values$login) {
         
        cat("here # 2")
            
        selectInput(
          inputId = "measure",
          label = "Select measure",
          choices = c("weight", "height", "head"),
          selected = "weight"
        )
      } else {
        NULL
      }
    })
  })
    
    
  observe({
    
    if (values$login & !is.null(input$measure)) {
      
      cat("here # 3")
      
      if (input$measure == "weight") {
        plotdata <- dat[, .(this_x = alder, this_y = vaegt, navn, dato, alder)]
        plotdata <- plotdata[!is.na(this_y), ]
        y_axis_lab <- "weight [kg]"
        unit <- "kg"
      }
      
      if (input$measure == "height") {
        plotdata <- dat[, .(this_x = alder, this_y = laengde, navn, dato, alder)]
        plotdata <- plotdata[!is.na(this_y), ]
        y_axis_lab <- "height [cm]"
        unit <- "cm"
      }
      
      if (input$measure == "head") {
        plotdata <- dat[, .(this_x = alder, this_y = hovede, navn, dato, alder)]
        plotdata <- plotdata[!is.na(this_y), ]
        y_axis_lab <- "head [cm]"
        unit <- "cm"
      }
      
      output$plot <- renderPlotly({
        ggplotly(
          ggplot() +
            geom_point(data = plotdata, aes(x = this_x, y = this_y, color = navn,
                                       text = paste0(navn, ", ", dato, ": ", round(this_y, 2), " ", unit))) +
            geom_line(data = plotdata, aes(x = this_x, y = this_y, color = navn)) +
            labs(x = "age [years]", y = y_axis_lab, color = "") +
            theme_ipsum(axis_title_size = 12) +
            scale_color_manual(values = cols)
          , tooltip = "text"
        )
      })
      
      
    } else {
      NULL
    }

  })
    
}