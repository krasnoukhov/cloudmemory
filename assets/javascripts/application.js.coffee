//= require jquery
//= require rotate

App =
  slides: ->
    $(".slide").each ->
      $slide = $(this)
      App.slide($slide)
      
      # Load images
      $slide.find(".image").each ->
        $image = $(this)
        query = "/photo/#{$image.attr("data-search-key")}/#{$image.attr("data-search-value")}"
        
        $.ajax(url: query, dataType: "json", type: "GET")
          .error (xhr, status, error) ->
            console.error error
          
          .done (result) ->
            $image.data("result", result)
            App.image($slide, $image)
  
  slide: ($slide) ->
    # Find position/dimensions
    original = (parseInt(value) for value in $slide.attr("data-size").split("x"))
    $slide.data("original", original)
    container = [$("section").width(), $("section").height()]
    final = [$("section").width(), $("section").height()]
    
    # Fit width
    if final[1] <= original[1]
      final[0] = Math.round(original[0]*final[1]/original[1])
    # Fit height
    else if final[0] <= original[1]
      final[1] = Math.round(original[1]*final[0]/original[0])
    else
      final = original
    
    $slide.find(".container").css
      width: final[0]
      height: final[1]
      marginLeft: "-#{final[0]/2}px"
      marginTop: "-#{final[1]/2}px"
  
  image: ($slide, $image) ->
    original = (parseInt(value) for value in $image.attr("data-size").split("x"))
    size = 
      width: Math.round(original[0]*$image.parent().width()/$slide.data("original")[0])
      height: Math.round(original[1]*$image.parent().height()/$slide.data("original")[1])
    
    original = (parseInt(value) for value in $image.attr("data-position").split(","))
    position =
      left: Math.round(original[0]*$image.parent().width()/$slide.data("original")[0])
      bottom: Math.round(original[1]*$image.parent().height()/$slide.data("original")[1])
    
    result = $image.data("result")
    $image.css
      width: size.width
      height: size.height
      left: position.left
      bottom: position.bottom
      backgroundImage: "url(#{result.images.standard_resolution.url})"
      backgroundSize: "#{size.width}px #{size.height}px"
    
    $image.rotate(parseInt($image.attr("data-rotate")))
    
$ ->
  App.slides()
  
  $(window).bind "resize", ->
    $(".slide").each ->
      $slide = $(this)
      App.slide($slide)
      
      $slide.find(".image").each ->
        $image = $(this)
        App.image($slide, $image) if $image.data("result")
