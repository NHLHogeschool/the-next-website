$ ->
  current_state = 0

  nextState = ->
    console.log 'wut'
    $a = $('header h1 a')
    $a.removeClass("state-#{current_state}")
    current_state += 1
    current_state = 1 if current_state == 5
    $a.addClass("state-#{current_state}")

    setTimeout nextState, 2000

  nextState()

  $('footer a').each (idx) ->
    $(this).attr('target', '_blank')
