class LSTriviaGame
  constructor: ->
    pusher = new Pusher(pusherKey)
    channel = pusher.subscribe('ls_trivia')
    channel.bind 'new_game', @show_game_if_team
    channel.bind 'game_end', @no_current_game
    channel.bind 'new_question', @show_question_if_in_game
    channel.bind 'times_up', @show_game_if_team

    $("#new_team").live 'submit', (event) =>
      # $("new_team_submit").prop('disabled', true)
      $("new_team_submit").hide()
      event.preventDefault()
      jqxhr = $.post("api/team", $("#new_team").serialize())
      jqxhr.done =>
        @show_waiting()
      jqxhr.fail =>
        @new_team()

    $("#new_response").live 'submit', (event) =>
      # $("new_response_submit").prop('disabled', true)
      $("#new_response").hide()
      event.preventDefault()
      jqxhr = $.post("api/question/responses", $("#new_response").serialize())
      jqxhr.done =>
        @show_waiting()
      jqxhr.fail =>
        @show_question()

  show_game_if_team: (data) =>
    $.getJSON "/api/team", (team) =>
      if team
        @show_waiting()
      else
        @new_team()

  show_question_if_in_game: (data) =>
    $.getJSON "/api/team", (team) =>
        @show_question() if team

  has_a_team: =>
    $.getJSON "/api/team", (team) =>
      team?

  show_waiting: (data) ->
    $.getJSON "/api/game", (game) ->
      $('#game').empty()
      $('#game').append Mustache.to_html($('#waiting_template').html(), game)

  show_question: (data) ->
    $.getJSON "/api/question/current", (question) ->
      $('#game').empty()
      $('#game').append Mustache.to_html($('#question_template').html(), question)

  no_current_game: (data) =>
    $('#game').empty()
    $('#game').append Mustache.to_html($('#no_game_template').html())

  new_team: (data) ->
    $.getJSON "/api/game", (game) ->
      $('#game').empty()
      $('#game').append Mustache.to_html($('#new_team_template').html(), game)

$ ->
  screen = new LSTriviaGame
  $.getJSON "/api/game", (game) ->
    if game
      $.getJSON "/api/team", (team) ->
        if team
          screen.show_waiting()
        else
          screen.new_team()
    else
      screen.no_current_game()
