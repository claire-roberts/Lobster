
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
    #                         tags$script('
    #           $(document).ready(function () {
    # #                                     navigator.geolocation.getCurrentPosition(onSuccess, onError);
    # #                                     
    # #                                     function onError (err) {
    # #                                     Shiny.onInputChange("geolocation", false);
    # #                                     }
    # #                                     
    # #                                     function onSuccess (position) {
    # #                                     setTimeout(function () {
    # #                                     var coords = position.coords;
    # #                                     console.log(coords.latitude + ", " + coords.longitude);
    # #                                     Shiny.onInputChange("geolocation", true);
    # #                                     Shiny.onInputChange("lat", coords.latitude);
    # #                                     Shiny.onInputChange("long", coords.longitude);
    # #                                     }, 1100)
    # #                                     }
    # #                                     });
    #                                     '), ## tags$script
    #                         tags$script('
    #           var TIMEOUT = 1000; //SPECIFY
    #           var started = false;
    #                                     function getLocationRepeat(){
    #                                     //first time only - no delay needed
    #                                     if (!started) {
    #                                     started = true;
    #                                     getLocation(getLocationRepeat);
    #                                     return;
    #                                     }
    #                                     
    #                                     setTimeout(function () {
    #                                     getLocation(getLocationRepeat);
    #                                     }, TIMEOUT);
    #                                     
    #                                     };
    #                                     
    #                                     getLocationRepeat();
    #                                     '),  
    #                         tags$script('
    #                                var options = {
    #                                   enableHighAccuracy: true,
    #                                   timeout: 5000,
    #                                   maximumAge: 0
    #                               };
    #                                     '), 
    # 
    # # Show a plot of the generated distribution
    # fluidRow(column(width = 2, 
    #                 verbatimTextOutput("lat"),
    #                 verbatimTextOutput("long"),
    #                 verbatimTextOutput("geolocation"))
    # ) ## fluid Row
    
    tags$script('
              $(document).ready(function () {
                
                function getLocation(callback){
                var options = {
                enableHighAccuracy: true,
                timeout: 5000,
                maximumAge: 0
                };
                
                navigator.geolocation.getCurrentPosition(onSuccess, onError);
                
                function onError (err) {
                Shiny.onInputChange("geolocation", false);
                }
                
                function onSuccess (position) {
                setTimeout(function () {
                var coords = position.coords;
                var timestamp = new Date();
                
                console.log(coords.latitude + ", " + coords.longitude, "," + coords.accuracy);
                Shiny.onInputChange("geolocation", true);
                Shiny.onInputChange("lat", coords.latitude);
                Shiny.onInputChange("long", coords.longitude);
                Shiny.onInputChange("accuracy", coords.accuracy);
                Shiny.onInputChange("time", timestamp)
                
                console.log(timestamp);
                
                if (callback) {
                callback();
                }
                }, 1100)
                }
                }
                
                var TIMEOUT = 100000; //SPECIFY
                var started = false;
                function getLocationRepeat(){
                //first time only - no delay needed
                if (!started) {
                started = true;
                getLocation(getLocationRepeat);
                return;
                }
                
                setTimeout(function () {
                getLocation(getLocationRepeat);
                }, TIMEOUT);
                
                };
                
                getLocationRepeat();
                
                });
                '),
    
    # Show a plot of the generated distribution
    fluidRow(column(width = 2,
                    verbatimTextOutput("lat"),
                    verbatimTextOutput("long"),
                    verbatimTextOutput("geolocation"),
                     verbatimTextOutput("accuracy")#,
                    # verbatimTextOutput("time"))
    )
    ) ## tabPanel
  
            ) ## navbarPage
))## ShinyUI
