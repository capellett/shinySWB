

### Custom Input Functions

## Projection Input
## Build out this function to make sure that the input is a proper PROJ definition.
projInput <- function(...) {
  shiny::textAreaInput(...)
}


## Tabular Input
## I can take a reactiveValues() list of the tabular input variables
## and left_join() it to the relevant input column names, units, and expected rows.
## and then verify that all of the expected columns and rows are present, 
## and seem to be in the correct units.


## Grid Input
## A lot of inputs can be provided gridded. I want a general function to handle them.
## I'll make a reactiveValues() list of gridded inputs
## and I'll pass the lists to a gridInput() function. 
# gridInputUI <- map(grid_inputs(), gridInput)
# shiny::fluidRow(gridInputUI)

## Then, to create the control file text output
# grid_input_tbl <- {} ## make a table, one row per input, columns for filetype, proj, etc.
# grid_ctl_output <- function() {} ## convert the grid_input_tbl rows to control file directives.

## This is deprecated, just let the user pick a file, and I can read the extension.
#   shiny::radioButtons(
#     inputId = "_grid_type", 
#     label = "Grid Type",
#     choiceNames = c('Arc Grid (.asc)', 'NetCDF (.nc)', 'Surfer Grid (.)')
# )




gridInput <- function(grid_variable, default_type, default_projection=default_proj) {

}



## Grid Adjustments

shiny::checkboxInput('_adjustments', 'Adjust Grid Values',
                     value=T)
### Offset, 'real value'
shiny::numericInput('_ADD_OFFSET', 'Add Constant Value:', value=0) 

### Scale Factor 'real value'
shiny::numericInput('_SCALE_FACTOR', 'Multiply by Scale Factor:', value=1) 

### Set Range, 'real value's
shiny::numericInput('_MINIMUM_ALLOWED_VALUE', 'Set Minimum Value:', -Inf)
shiny::numericInput('_MAXIMUM_ALLOWED_VALUE', 'Set Maximum Value:', Inf)



### Missing Values

shiny::numericInput('_MISSING_VALUES_CODE', 'Missing Values Code:', NA_real_) 
## real or int

shiny::radioButtons(
  '_MISSING_VALUES_OPERATOR', 'Missing Values Operator:',
  c('<', '<=', '>', '>='))

shiny::radioButtons(
  '_MISSING_VALUES_ACTION', 'Missing Values Action:',
  c('None', 'Mean', 'Zero'))


### NetCDF Options
### strings
shiny::textInput('_NETCDF_X_VAR', 'Name of the X axis variable:')

shiny::textInput('_NETCDF_Y_VAR', 'Name of the Y axis variable:')

shiny::textInput('_NETCDF_Z_VAR', 'Name of the Z axis variable (the grid cell values):')

shiny::textInput('_NETCDF_TIME_VAR', 'Name of the Time axis variable:')

shiny::radioButtons(
  '_NETCDF_VARIABLE_ORDER', 'Variable order:',
  choices = c('xyt', 'txy'))

shiny::checkboxGroupInput(
  '_netcdf_flip', label='Flip Grid',
  choiceNames = c('Flip Vertical', 'Flip Horizontal'),
  choiceValues = c('_NETCDF_FLIP_VERTICAL', '_NETCDF_FLIP_HORIZONTAL'))




# ## make a more generic load file function(?)
# check_input_file_type <- function(name, path) {
#   ext <- tools::file_ext(name)
#   if(ext %in% c('asc', 'grd', 'nc')) {
#     file_format <- 'grid'
#   } else if(ext %in% c('csv', 'xls', 'xlsx'))
#   switch(ext,
#          asc = {},
#          grd = {}
#          nc = {},
#          shiny::validate("Invalid file; Please choose a .asc or .grd or .nc grid file."))
# }


