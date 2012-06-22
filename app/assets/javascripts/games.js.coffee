# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

class LSTriviaGame
  constructor: ->
    $.getJSON "/api/game", (game) ->
      if game
        $('#game').append Mustache.to_html($('#game_template').html(), game)
      else
        $('#game').append Mustache.to_html($('#no_game_template').html())

    pusher = new Pusher("7f1590723727b1a008b1")
    channel = pusher.subscribe('ls_trivia')
    channel.bind 'new_game', @show_game

  show_game: (data) ->
    $.getJSON "/api/game", (game) ->
      $('#game').empty()
      $('#game').append Mustache.to_html($('#game_template').html(), game)

$ ->
  new LSTriviaGame
