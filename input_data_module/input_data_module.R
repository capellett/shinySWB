



inputDataUI <- function(id, label='example input data',gridded=T, tabular=T) {
  # accepted_extensions <- c(
  #   if(gridded) {c('.asc', '.grd', '.nc')},
  #   if(tabular) {'.txt'} # '.tsv', '.csv', '.xls', '.xlsx'
  # )
  
  # if(length(accepted_extensions)==0) {
  #   return(shiny::tagList(shiny::numericInput(shiny::NS(id, 'constant_input'))))
  # }
  
  shiny::tagList(
    shinyFiles::shinyFilesButton(
      id = shiny::NS(id, 'file_name'),
      label = 'Test Input',
      title = 'testinput',
      multiple = FALSE),
    #  accept = accepted_extensions),
    # shinywidgets::selectFile()
    # file.choose()
    
    shiny::verbatimTextOutput(shiny::NS(id, 'rawInputValue')),
    
    shiny::verbatimTextOutput(shiny::NS(id, 'filepaths'))
    
    # shiny::textOutput(
    #   outputId = shiny::NS(id, 'extension')
    # )
    
  )
}

## Hopefully, If I don't call the fileInput data, I only use its name,
## Then shiny won't actually import the data...(?)
inputDataServer <- function(id) {
  shiny::moduleServer(id, function(input, output, session) {
    
    volumes = c(Home = fs::path_home(),
                shinyFiles::getVolumes()())
    
    shinyFiles::shinyFileChoose(
      input=input,
      id='file_name',
      roots=volumes,
      session=session,
      updateFreq = 0, ## this is watching updates in the file system.
      defaultRoot = 'Home',
      defaultPath = '',
      filetypes=c('txt', 'asc', 'grd', 'nc'))
    
    output$rawInputValue <- renderPrint({str(input$file_name)})
    
    output$filepaths <- renderPrint({
      if(is.integer(input$file_name)) {
        cat("Select an input file.")
      } else {
        shinyFiles::parseFilePaths(
          roots= volumes,
          selection=input$file_name)
      }
    })
    
    
    # extension <- shiny::reactive(tools::file_ext(input$file_name))
    # output$extension <- shiny::renderText(extension())
  })
}


inputApp <- function() {
  ui <- shiny::fluidPage(inputDataUI('example'))
  server <- function(input, output, session) {
    inputDataServer('example')
  }
  shiny::shinyApp(ui, server)
}

inputApp()

# shiny::runApp(list(
#   ui=shiny::fluidPage(inputDataUI('example')),
#   
#   sever=function(input, output, session) {
#     #     inputDataServer('example')
# )
# )

