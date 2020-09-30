ui <- dashboardPage(
  dashboardHeader(
    title = "Lauge & Emil",
    titleWidth = 300
  ),
  
  dashboardSidebar(
    width = 300,
    
    HTML("<h4>Log in</h4>"),
    
    textInput(inputId = "username",
              label = "User name"),
    
    passwordInput(inputId = "pwd",
                  label = "Password:"),
    
    actionButton(inputId = "login", 
                 label = "Log in"),
    
    uiOutput("logInStatus")
    
  ),
  
  dashboardBody(
    tabsetPanel(
      id = "tabs",
      tabPanel(
        title = "Lauge & Emil",
        value = "page1",
        br(),
        uiOutput("statusMessage"),
        uiOutput("selectMeasure"),
        plotlyOutput("plot")
      )
    )
  )
)