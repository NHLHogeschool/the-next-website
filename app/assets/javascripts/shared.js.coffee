$ ->
  current_state = 0

  if $.cookie('current_state')
    current_state = parseInt($.cookie('current_state'))

  nextState = ->
    $a = $('header h1 a')
    $a.removeClass("state-#{current_state}")
    current_state  = 0 if current_state == 4
    current_state += 1
    $a.addClass("state-#{current_state}")

    $.cookie('current_state', current_state)

    setTimeout nextState, 2000

  nextState()
