$("#subcategory_select").empty().append("<%= escape_javascript(render(:partial => @subcategories)) %>")

show_subcategories = (evt) ->
  category_id = $("#category_select").val()
  switch category_id
    when "31", "32", "33"
      $("#subCategory").hide()
    when "34", "35", "36"
      $("#subCategory").show()  

show_subcategories()
