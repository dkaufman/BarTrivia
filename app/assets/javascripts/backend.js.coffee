class LSTriviaBackend
  current_question = {}

  constructor: ->
    $("#times_up").hide()

    pusher = new Pusher(pusherKey)
    channel = pusher.subscribe('ls_trivia')
    channel.bind 'new_response', (response_id) =>
      @show_new_response(response_id)
    channel.bind 'new_team', LSTriviaBackend.update_teams

    $("#next_question").bind 'click', (event) =>
      event.preventDefault()
      @show_next_question()

    $("#times_up").bind 'click', (event) =>
      event.preventDefault()
      @times_up()

    $(".mark_as_correct").live 'click', (event) ->
      event.preventDefault()
      $.post "api/question/responses/#{$(this).attr('data')}/correct", (response) =>
        $(this).hide()
      LSTriviaBackend.update_teams()

  show_new_response: (response_id) ->
    $.getJSON "/api/question/responses/#{response_id}", (response) =>
      $("#responses").append Mustache.to_html($("#response_template").html(), response)

  show_next_question: ->
    $('#next_question').hide()
    $("#times_up").show()
    $("#responses").empty()

    $.getJSON "/api/question", (question) =>
      current_question = question
      $('#questions').append Mustache.to_html($('#ask_question_template').html(), current_question)

  times_up: ->
    $("#times_up").hide()
    $(".hidden_solutions").removeClass("hidden")
    $('#questions').append Mustache.to_html($('#show_solution_template').html(), current_question)

    $.post "/api/question/times_up"
    $.getJSON "/api/question/last", (is_last_question) =>
      $('#next_question').show() unless is_last_question

  @update_teams: ->
    $.getJSON "/api/team/all", (teams) =>
      $('#teams').empty()
      $('#teams').append Mustache.to_html($('#teams_template').html(), teams)

$ ->
  backend = new LSTriviaBackend
