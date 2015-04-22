$ ->
  show_subcategories = (evt) ->
    category_id = $("#category_select").val()
    switch category_id
      when "31", "32", "33"
        $("#subCategory").hide()
      when "34", "35", "36"
        $("#subCategory").show()  

  $(document).on 'change', '#category_select', (evt) ->
    $.ajax 'update_subcategories',
      type: 'GET'
      dataType: 'script'
      data: {
        category_id: $("#category_select option:selected").val()
      }
      error: (jqXHR, textStatus, errorThrown) ->
        console.log("AJAX Error: #{textStatus}")
      success: (data, textStatus, jqXHR) ->
        # console.log("Dynamic category select OK!")

  show_subcategories()