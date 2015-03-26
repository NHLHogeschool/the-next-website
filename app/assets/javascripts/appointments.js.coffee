$ ->
  $tool = $('#appointment-tool')

  if $tool.length

    ROOT_URL = 'http://www.cmd-leeuwarden.nl/subscriptions'
    DAYS = ['Maandag', 'Dinsdag', 'Woendag', 'Donderdag', 'Vrijdag']

    TEACHERS =
      raymond:
        name: 'Raymond van Dongelen'
        skills: ['Design Science', 'iOS']
        working_days: [0, 1, 2, 3]
        subscription_id: 1606
      janwessel:
        name: 'Jan-Wessel Hovingh'
        skills: ['Vormgeving', 'Klanten']
        working_days: [1, 2, 3]
        subscription_id: 1746
      sjef:
        name: 'Sjef Smeets'
        skills: ['Interaction Design', 'Research', 'Functional Design',
                 'Usability', 'Experience Design']
        working_days: [0, 1, 2, 3]
        email: 'j.p.a.smeets@nhl.nl'
      dirksierd:
        name: 'Dirk Sierd de Vries'
        skills: ['Ruby on Rails', 'JavaScript', 'PHP']
        working_days: [1, 3, 4]
        email: 'd.s.de.vries@nhl.nl'
      amarins:
        name: 'Amarins Schuilenburg'
        skills: ['Persoonlijke Professionele Ontwikkeling']
        working_days: [0, 1, 2, 3, 4]
        email: 'amarins.schuilenburg@nhl.nl'

    $skill_select = $('<select/>')

    $option = $('<option/>').html('')
    $skill_select.append($option)

    $skill_select.change (evt) ->
      $('article').remove()

      key = $(this).val()
      return unless key.length

      teacher = TEACHERS[key]
      $info = $('<article/>')
      $info.append $('<h3/>').html(teacher.name)

      $days = $('<ul/>')
      for day in teacher.working_days
        $days.append $('<li/>').html(DAYS[day])
      $info.append($days)

      if teacher.email
        title = 'Stuur een e-mail'
        url = "mailto:#{teacher.email}"
      else
        title = 'Schrijf je digitaal in'
        url = "#{ROOT_URL}/#{teacher.subscription_id}"

      $contact = $('<a/>').html(title).attr(href: url)
      $info.append($contact)

      $skill_select.after($info)

    sorted_skills = {}
    for key, teacher of TEACHERS
      for skill in teacher.skills
        sorted_skills[skill] = key

    for skill in Object.keys(sorted_skills).sort()
      $option = $('<option/>').val(sorted_skills[skill]).html(skill)
      $skill_select.append($option)

    $tool.html('').append($skill_select)
