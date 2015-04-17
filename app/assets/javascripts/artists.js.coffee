$ ->
  initArtistPage()

initArtistPage = (e) ->
  $('#artist_born_on').datepicker
    dateFormat: "dd M yy"
  $('#artist_died_on').datepicker
    dateFormat: "dd M yy"
