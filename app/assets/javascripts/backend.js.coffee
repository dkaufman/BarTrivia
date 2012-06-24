$ ->
  $("#times_up").hide()
  current_question = {}
  $("#next_question").click (event) ->
    event.preventDefault()
    $('#next_question').hide()
    $("#times_up").show()
    $.getJSON "/api/question", (question) =>
      current_question = question
      $('#questions').append Mustache.to_html($('#ask_question_template').html(), current_question)

  $("#times_up").click (event) ->
    event.preventDefault()
    $.getJSON "/api/question/last", (is_last_question) =>
      $('#next_question').show() unless is_last_question
    $("#times_up").hide()
    $('#questions').append Mustache.to_html($('#show_solution_template').html(), current_question)
