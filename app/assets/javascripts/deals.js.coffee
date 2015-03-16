ready = ->
  $('.start-date').datepicker()
  $('.end-date').datepicker()

$(document).ready(ready)
$(document).on('page:load', ready)