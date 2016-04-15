shinyServer(function(input, output, session) {
  
  ## Interactive Map ###########################################
 # Create the map
  output$map <- renderLeaflet({
    leaflet() %>%
      addTiles('http://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}',
               options = providerTileOptions(noWrap = TRUE)) %>%
      addTiles('http://server.arcgisonline.com/ArcGIS/rest/services/Reference/World_Boundaries_and_Places/Mapserver/tile/{z}/{y}/{x}',
               options = providerTileOptions(noWrap = TRUE)) %>%
      
      #setView(-81.41, 26.15, zoom = 8) %>% 
    addPolygons(data=lobs, stroke=FALSE, smoothFactor=0.2, fillOpacity=1.0,
                color="yellow") 
    
    
    
  }) ## renderLeaflet
  
## Adding geolocation component ##
  
  output$lat <- renderPrint({
    input$lat
  }) ## renderPrint
  
  output$long <- renderPrint({
    input$long
  }) ## renderPrint
  
  output$geolocation <- renderPrint({
    input$geolocation
  }) ## renderPrint
  
  output$accuracy <- renderPrint({
    input$accuracy
  })
  
  output$time <- renderPrint({
    input$time
  })
  
  ###observer to change map based on location##
  
  observe({
    if(!is.null(input$lat)){
      map <- leafletProxy("map")
      dist <- 0.5
      lat <- input$lat
      lng <- input$long
      map %>% fitBounds(lng - dist, lat - dist, lng + dist, lat + dist) %>% 
      #addMarkers(-81.41, 26.15) %>% 
        addMarkers(lng,lat) %>% 
        addRectangles(lng1=  -82.517131, lat1=27.963717,
                      lng2=-82.511541, lat2=27.959590,
                      fillColor="#dd1c77", fillOpacity = 1,
                      color = "#dd1c77") %>% 
        addRectangles(lng1=  -82.635620, lat1=27.956195,
                      lng2=-82.597855, lat2=27.932922,
                      fillColor="#dd1c77", fillOpacity = 1,
                      color = "#dd1c77")
    }
  })
  
  
  
  
}) #shinyServer