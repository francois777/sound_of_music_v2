$ ->
  show_subcategories = (evt) ->
    category = $("#category_select").val()
    switch category
      when "7", "8", "9"
        $("#subCategory").hide()
      when "10", "11", "12"
        $("#subCategory").show()  

  $(document).on 'change', '#category_select', (evt) ->
    $.ajax 'update_subcategories',
      type: 'GET'
      dataType: 'script'
      data: {
        category: $("#category_select option:selected").val()
      }
      error: (jqXHR, textStatus, errorThrown) ->
        console.log("AJAX Error: #{textStatus}")
      success: (data, textStatus, jqXHR) ->
        # console.log("Dynamic category select OK!")

  show_subcategories()