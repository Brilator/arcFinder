

suppressMessages(library(tidyverse))
suppressMessages(library(shiny))

load("../.tmp03_allARCs.RData")

### Flatten ALL values into a 3-column (arc_id | key | value) df to provide search across "any field"

all_values <- do.call(
  rbind.data.frame, lapply(all_arcs_db, function(x){
  pivot_longer(x, cols = setdiff(colnames(x), "arc_id"), values_drop_na = T)}))

all_values <- as.data.frame(all_values)

arc_list <- unique(arc_list)

shinyApp(
    ui = pageWithSidebar(
        headerPanel("ARC Finder"),
        sidebarPanel(
            selectizeInput('search_key', 'Select a field to search', choices = c("Any field", unique(all_values$name))),
            uiOutput("search_field"), 
            selectInput(inputId = "arc_path", label = "Select an ARC for details", choices = NULL),
            br(),
            actionButton("go", "Show this ARC"),
            h3("Access this ARC in the DataHUB"),
            uiOutput("arc_gitlab"),
             
        ),
        
        mainPanel(
          h3("Overview"),
          tableOutput("table_INV"),
          br(),
          h3("Publications"),
          tableOutput("table_INV_PUBS"),
          br(),
          h3("Contacts"),
          tableOutput("table_INV_Contacts")
        )
    ),
    
    server = function(input, output, session) {
      
      
      ##### reactive input field for text-search
          
        
      output$search_field <- renderUI({
        
        # check whether user wants to filter by cyl;
        # if not, then filter by selection
        if ('Any field' %in% input$search_key) {
            df <- all_values
        } else {
            df <- subset(all_values, name == input$search_key)
        }
        
      
      selectizeInput('search_value', 'Search the ARC database', choices = c("", sort(unique(df$value))))
      
      })
      
      
      ##### ARC choices (arc_id) matching user-input
      
        arc_choices_id <- reactive({ 
          
        if ('Any field' %in% input$search_key) {
            
          subset(all_values, value == input$search_value, arc_id, drop = T)
          
          } else {
          
          subset(all_values, name == input$search_key & value == input$search_value, arc_id, drop = T)
          }
          
        })
      
        
        ### retrieve path for matching ARCs from arc list
        
        arc_choices_path <- reactive({
        
        subset(arc_list, arc_id %in% arc_choices_id(), ARC.path, drop = T)
      
        })

      ##### reactive ARC selection: updated Input to let user pick from 
          
        
        observe({
          updateSelectInput(session = session, inputId = "arc_path", choices = arc_choices_path())
          })
        
        
     #### User's ARC choice 
        
        selected_arc <- eventReactive(input$go, {
        
        all_arcs[[as.character(subset(arc_list, ARC.path %in% input$arc_path, arc_id, drop = T))]]
      
        })
      
        
      ##### render table INVESTIGATION 
        
        output$table_INV <- renderTable(colnames = F, rownames = F, {
          
          selected_table <- selected_arc()$INVESTIGATION
          selected_table <- selected_table[, -which(colnames(selected_table) == "arc_id")]
          
          selected_table$pivot_col <- row.names(selected_table)
          long <- pivot_longer(selected_table, setdiff(colnames(selected_table), "pivot_col"), values_drop_na = T)
          
          pivot_wider(long, names_from = pivot_col)
          
        })        
      
      ##### render table INVESTIGATION PUBLICATIONS
        
        output$table_INV_PUBS <- renderTable(colnames = F, rownames = F, {
          
          selected_table <- selected_arc()$`INVESTIGATION PUBLICATIONS`
          selected_table <- selected_table[, -which(colnames(selected_table) == "arc_id")]
          
          selected_table$pivot_col <- row.names(selected_table)
          long <- pivot_longer(selected_table, setdiff(colnames(selected_table), "pivot_col"), values_drop_na = T)
          
          pivot_wider(long, names_from = pivot_col)
          
          
        })
        
      ##### render table INVESTIGATION CONTACTS
        
        output$table_INV_Contacts <- renderTable(colnames = F, rownames = F, {
          
          
          selected_table <- selected_arc()$`INVESTIGATION CONTACTS`
          selected_table <- selected_table[, -which(colnames(selected_table) == "arc_id")]

          selected_table$pivot_col <- row.names(selected_table)
          long <- pivot_longer(selected_table, setdiff(colnames(selected_table), "pivot_col"), values_drop_na = T)
          
          pivot_wider(long, names_from = pivot_col)
            
        })
        
    ##### render link to gitlab

        output$arc_gitlab <- renderUI(a(href = paste0('https://git.nfdi4plants.org/', input$arc_path), 
                                        paste0('https://git.nfdi4plants.org/', input$arc_path) ,target="_blank"))
        
        
        session$onSessionEnded(function() {
          stopApp()
        })
    }
    
)
          





