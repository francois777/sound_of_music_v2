$("#subcategory_select").empty().append("<%= escape_javascript(render(:partial => @subcategories)) %>")

getSelectedText = (elementId) ->
  elt = document.getElementById(elementId)
  if elt.selectedIndex == -1
    return null
  elt.options[elt.selectedIndex].text

show_subcategories = (evt) ->
  text = getSelectedText('category_select')
  switch text
    when "Brass", "Electronic", "Keyboard"
      $("#subCategory").hide()
    when "Percussion", "Strings", "Woodwind"
      $("#subCategory").show()  

show_subcategories()
