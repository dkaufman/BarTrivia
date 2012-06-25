class LSTriviaBackend
  constructor: ->
    pusher = new Pusher(pusherKey)
    channel = pusher.subscribe('ls_trivia')
    channel.bind 'new_response', (response_id) =>
      @show_new_response(response_id)

  show_new_response: (response_id) ->
    $.getJSON "/api/question/responses/#{response_id}", (response) =>
      $("#responses").append Mustache.to_html($("#response_template").html(), response)

$ ->
  backend = new LSTriviaBackend

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
    $.post "/api/question/times_up", "json"
    $("#times_up").hide()
    $('#questions').append Mustache.to_html($('#show_solution_template').html(), current_question)
    $.getJSON "/api/question/last", (is_last_question) =>
      $('#next_question').show() unless is_last_question
    # $(".hidden_solu
