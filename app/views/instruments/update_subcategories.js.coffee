$("#subcategory_select").empty().append("<%= escape_javascript(render(:partial => @subcategories)) %>")

show_subcategories = (evt) ->
  category = $("#category_select").val()
  switch category
    when "7", "8", "9"
      $("#subCategory").hide()
    when "10", "11", "12"
      $("#subCategory").show()  

show_subcategories()


