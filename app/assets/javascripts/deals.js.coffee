ready = ->
  $('.start-date').datepicker({format: 'yyyy-mm-dd',  autoclose: true})
  $('.end-date').datepicker({format: 'yyyy-mm-dd',  autoclose: true})

$(document).ready(ready)
$(document).on('page:load', ready)