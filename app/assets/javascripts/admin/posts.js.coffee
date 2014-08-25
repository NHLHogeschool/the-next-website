$ ->
  $('.post-form').on 'keyup', 'textarea', ->
    window.$textarea = $(this)
    remaining = 140 - $textarea.val().length
    $('.character-count').html(remaining)
