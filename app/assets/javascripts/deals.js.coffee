ready = ->
  $('.start-date').datepicker({format: 'yyyy-mm-dd'})
  $('.end-date').datepicker({format: 'yyyy-mm-dd'})

$(document).ready(ready)
$(document).on('page:load', ready)