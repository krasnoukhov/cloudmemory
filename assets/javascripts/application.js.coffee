//= require jquery

App =
  slide: ->
    $(".image").each ->
      $this = $(this)
      query = "/photo/" + ([key, value].join("/") for key, value of $(this).data())
      
      $.ajax(url: query, dataType: "json", type: "GET")
        .error (xhr, status, error) ->
          console.error error
        
        .done (result) ->
          $this.html("<img src='#{result.images.standard_resolution.url}' />")

$ ->
  App.slide()
