class LSTriviaBackend
  current_question = {}

  constructor: ->
    $("#times_up").hide()
    $("#done_grading").hide()
    $("#end_game").hide()
    $('#sidebar-header').html Mustache.to_html($('#teams_header').html(), current_question)
    @update_questions_remaining()
    LSTriviaBackend.update_teams()

    pusher = new Pusher(pusherKey)
    channel = pusher.subscribe('ls_trivia')
    channel.bind 'new_response', (response_id) =>
      @show_new_response(response_id)
    channel.bind 'new_team', LSTriviaBackend.update_teams

    $("#next_question").bind 'click', (event) =>
      event.preventDefault()
      @show_next_question()
      timer = new Timer
      timer.start()

    $("#times_up").live 'click', (event) =>
      event.preventDefault()
      @times_up()

    $("#done_grading").bind 'click', (event) =>
      event.preventDefault()
      @done_grading()

    $(".mark_as_correct").live 'click', (event) ->
      event.preventDefault()
      $.post "api/question/responses/#{$(this).attr('data')}/correct", (response) =>
        $("#response_#{$(this).attr('data')}_row").hide()
        $("#response_#{$(this).attr('data')}_separator").hide()
      LSTriviaBackend.show_number_correct()

  show_new_response: (response_id) ->
    $.getJSON "/api/question/responses/#{response_id}", (response) =>
      $("#team_#{response.team_id}_points").append("<span class='check'><i class='icon-ok'></i></span>")

  show_next_question: ->
    $(".question").removeClass("with_solution")
    $(".check").remove()
    $('#next_question').hide()
    $("#solution").hide()
    $("#times_up").show()
    $("#questions").empty()
    $("#responses").empty()
    @show_teams()

    $.getJSON "/api/question", (question) =>
      current_question = question
      $('#questions').append Mustache.to_html($('#ask_question_template').html(), current_question)

    @update_questions_remaining()

  times_up: ->
    $("#times_up").hide()
    $("#done_grading").show()
    $("#solution").show()
    $(".question").addClass("with_solution")
    $(".hidden_solutions").removeClass("hidden")
    $('#solution').html Mustache.to_html($('#show_solution_template').html(), current_question)

    $.post "/api/question/times_up"
    @auto_grade_responses()
    @show_responses()

  auto_grade_responses: ->
    $.post "/api/question/responses/auto_grade"

  done_grading: ->
    $("#done_grading").hide()
    @show_teams()
    $.getJSON "/api/question/last", (is_last_question) =>
      if is_last_question
        $('#end_game').show()
      else
        $('#next_question').show()

  show_responses: ->
    $('#sidebar-header').html Mustache.to_html($('#responses_header').html(), current_question)
    $('#teams').empty()
    LSTriviaBackend.show_number_correct()
    @show_other_responses()

  show_other_responses: ->
    $.getJSON "/api/question/responses", (responses) =>
      $('#responses').html Mustache.to_html($('#responses_template').html(), responses)

  show_teams: ->
    $('#sidebar-header').html Mustache.to_html($('#teams_header').html(), current_question)
    LSTriviaBackend.update_teams()

  update_questions_remaining: ->
    $.getJSON "/api/question/count", (count) =>
      $('#questions_remaining').html Mustache.to_html($('#remaining_template').html(), count)

  @update_teams: ->
    $("#number_correct").empty()
    $("#responses").empty()
    $.getJSON "/api/team/all", (teams) =>
      $('#teams').empty()
      $('#teams').append Mustache.to_html($('#teams_template').html(), teams)

  @show_number_correct: ->
    $.getJSON "/api/question/responses/number_correct", (count) =>
      $('#number_correct').html Mustache.to_html($('#number_correct_template').html(), count)


$ ->
  backend = new LSTriviaBackend
