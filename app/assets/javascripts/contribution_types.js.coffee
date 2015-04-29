$ ->
  getSelectedText = (elementId) ->
    elt = document.getElementById(elementId)
    if elt == null or elt.selectedIndex == -1
      return null
    elt.options[elt.selectedIndex].text

  $(document).on 'change', '#classification', (evt) ->
    classification = getSelectedText( "classification" )
    console.log(classification)
    switch classification
      when "Vocalist"
        $("#group_type").hide()
        $("#voice_type").show()
        document.getElementById("contribution_type_voice_type").value = "1"
        document.getElementById("contribution_type_group_type").value = "0"
      when "Group of musicians"  
        $("#group_type").show()
        $("#voice_type").hide()
        document.getElementById("contribution_type_group_type").value = "1"
        document.getElementById("contribution_type_voice_type").value = "0"
      else
        $("#group_type").hide()
        $("#voice_type").hide()
        document.getElementById("contribution_type_group_type").value = "0"
        document.getElementById("contribution_type_voice_type").value = "0"

