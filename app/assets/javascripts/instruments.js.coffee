$ ->

  getSelectedText = (elementId) ->
    elt = document.getElementById(elementId)
    if elt == null or elt.selectedIndex == -1
      return null
    elt.options[elt.selectedIndex].text

  show_subcategories = (evt) ->
    text = getSelectedText('category_select')
    console.log(text)
    switch text
      when "Brass", "Electronic", "Keyboard"
        $("#subCategory").hide()
      when "Percussion", "Strings", "Woodwind"
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

  $("#subCategory").hide()
  show_subcategories()