$ ->
  current_state = 0

  nextState = ->
    console.log current_state

    $a = $('header h1 a')
    $a.removeClass("state-#{current_state}")
    current_state  = 0 if current_state == 4
    current_state += 1
    $a.addClass("state-#{current_state}")

    setTimeout nextState, 2000

  nextState()
