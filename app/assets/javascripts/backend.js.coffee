$ ->
  $("#next_question").click (event) ->
    event.preventDefault()
    $.getJSON "/api/question", (question) =>
      $('#question').empty()
      $('#next_question').toggle()
      $('#question').append Mustache.to_html($('#ask_question_template').html(), question)
