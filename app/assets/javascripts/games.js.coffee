# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$.getJSON "/current_game", (data) ->
  if data
    $('#game').append Mustache.to_html($('#game_template').html(), data)
  else
    $('#game').append Mustache.to_html($('#no_game_template').html())
