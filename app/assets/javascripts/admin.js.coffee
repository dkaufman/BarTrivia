$ ->
  $(".show-questions").bind 'click', (event) ->
    event.preventDefault()
    $.getJSON "/api/pending_games/#{$(this).attr('data')}", (game) ->
      $("#question-list").html Mustache.to_html($('#question_list_template').html(), game)
  $(".add-question").bind 'click', (event) ->
    console.log($(this))
    event.preventDefault()
    $("#question-list").html Mustache.to_html($('#new_question_template').html(), $(this).attr("data"))
