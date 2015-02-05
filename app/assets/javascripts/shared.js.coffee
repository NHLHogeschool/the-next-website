$ ->
  $('section > table').each (idx) ->
    $table = $(this)

    $div = $('<div/>').addClass('table-wrapper')
                      .html(this.outerHTML)

    $table.after($div).remove()
