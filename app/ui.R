library(shiny)
library(shinydashboard)



menu_item <- function (
    text, 
    ..., 
    img_src = NULL, 
    badgeLabel = NULL, 
    badgeColor = "green", 
    tabName = NULL, 
    href = NULL, 
    newtab = TRUE, 
    selected = NULL, 
    expandedName = as.character(gsub("[[:space:]]", "", text)), 
    startExpanded = FALSE
) {
  
  
  subItems <- list(...)
  
  # I converted the icon tag to an image tag ------------------------------
  if (!is.null(img_src)) {
    
    img_tag <- htmltools::tags$img(
      src = img_src,
      # default size of the image `you can edit the height & width values`
      # and also the space between the image and the text.
      # you can further style the image here.
      style = "height: 3rem; width: 3rem; margin-right: 0.6rem;"
    )
    
  }
  
  if (!is.null(href) + !is.null(tabName) + (length(subItems) > 0) != 1) {
    
    stop("Must have either href, tabName, or sub-items (contained in ...).")
    
  }
  
  if (!is.null(badgeLabel) && length(subItems) != 0) {
    
    stop("Can't have both badge and subItems")
    
  }
  
  shinydashboard:::validateColor(badgeColor)
  
  isTabItem <- FALSE
  target <- NULL
  
  if (!is.null(tabName)) {
    
    shinydashboard:::validateTabName(tabName)
    
    isTabItem <- TRUE
    
    href <- paste0("#shiny-tab-", tabName)
    
  } else if (is.null(href)) {
    
    href <- "#"
    
  } else {
    
    if (newtab) target <- "_blank"
    
  }
  
  
  if (!is.null(badgeLabel)) {
    
    badgeTag <- htmltools::tags$small(
      class = paste0("badge pull-right bg-",badgeColor), 
      badgeLabel
    )
    
  } else {
    
    badgeTag <- NULL
    
  }
  
  
  if (length(subItems) == 0) {
    
    return(
      htmltools::tags$li(
        htmltools::a(
          href = href, 
          `data-toggle` = if (isTabItem) "tab", 
          `data-value` = if (!is.null(tabName)) tabName, 
          `data-start-selected` = if (isTRUE(selected)) 1 else NULL, 
          target = target, 
          img_tag, 
          htmltools::span(text), 
          badgeTag
        )
      )
    )
    
  }
  
  default <- if (startExpanded) expandedName else ""
  
  dataExpanded <- shiny::restoreInput(id = "sidebarItemExpanded", default) %OR% ""
  
  isExpanded <- nzchar(dataExpanded) && (dataExpanded == expandedName)
  
  htmltools::tags$li(
    class = "treeview", 
    htmltools::a(
      href = href, 
      img_tag, 
      htmltools::span(text), 
      shiny::icon("angle-left", class = "pull-right")
    ), 
    
    do.call(
      htmltools::tags$ul, 
      
      c(
        class = paste0("treeview-menu", if (isExpanded) " menu-open" else ""), 
        style = paste0("display: ", if (isExpanded) "block;" else "none;"), 
        `data-expanded` = expandedName, 
        subItems
      )
    )
  )
  
}



dashboardPage(
  dashboardHeader(),
  
  dashboardSidebar(
    sidebarMenu(
      menuItem(
        "Dashboard",
        tabName = "dashboard",
        icon = icon("dashboard")
      ),
      menuItem(
        "Widgets",
        tabName = "widgets",
        icon = icon("th")
      ),
      menu_item(
        "Test",
        tabName = "test",
        img_src = "timg.jpg"
      )
    )
  ),
  
  dashboardBody(
    tabItems(
      tabItem(
        tabName = "dashboard",
        
        h1("Dashboard Page")
      ),
      tabItem(
        tabName = "widgets",
        
        h1("Widgets Page")
      ),
      tabItem(
        tabName = "test",
        
        h1("Test Page")
      )
    )
  ),
)