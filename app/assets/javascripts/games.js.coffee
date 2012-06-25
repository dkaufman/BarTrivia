# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

class LSTriviaGame
  constructor: ->
    pusher = new Pusher(pusherKey)
    channel = pusher.subscribe('ls_trivia')
    channel.bind 'new_game', @show_game_if_team
    channel.bind 'game_end', @no_current_game
    channel.bind 'new_question', @show_question_if_in_game
    channel.bind 'times_up', @show_game_if_team

  show_game_if_team: (data) =>
    $.getJSON "/api/team", (team) =>
      if team
        @show_game()
      else
        @new_team()

  show_question_if_in_game: (data) =>
    $.getJSON "/api/team", (team) =>
        @show_question() if team

  has_a_team: =>
    $.getJSON "/api/team", (team) =>
      team?

  show_game: (data) ->
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
          screen.show_game()
        else
          screen.new_team()
    else
      screen.no_current_game()
