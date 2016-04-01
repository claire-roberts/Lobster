
shinyUI(navbarPage("Lobster Closed Areas", id="nav",
                   
                   tabPanel("Lobster",
                            div(class="outer",
                                
                                tags$head(
                                  # Include our custom CSS
                                  includeCSS("styles.css"),
                                  includeScript("gomap.js")
                                ), #tags$head
                                
                                leafletOutput("map", width="100%", height="100%")
                                
                                
                            ), ## div
                            tags$script('
              $(document).ready(function () {
                                        navigator.geolocation.getCurrentPosition(onSuccess, onError);
                                        
                                        function onError (err) {
                                        Shiny.onInputChange("geolocation", false);
                                        }
                                        
                                        function onSuccess (position) {
                                        setTimeout(function () {
                                        var coords = position.coords;
                                        console.log(coords.latitude + ", " + coords.longitude);
                                        Shiny.onInputChange("geolocation", true);
                                        Shiny.onInputChange("lat", coords.latitude);
                                        Shiny.onInputChange("long", coords.longitude);
                                        }, 1100)
                                        }
                                        });
                                        '), ## tags$script

    # Show a plot of the generated distribution
    fluidRow(column(width = 2, 
                    verbatimTextOutput("lat"),
                    verbatimTextOutput("long"),
                    verbatimTextOutput("geolocation"))
    ) ## fluid Row
                  
                   ) ## tabPanel
  
            ) ## navbarPage
)## ShinyUI
