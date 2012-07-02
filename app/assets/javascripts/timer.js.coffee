class Timer
  constructor: ->
    $("#times_up").live 'click', (event) =>
      event.preventDefault()
      @stop_timer()

  every: (ms, cb) =>
    @interval = setInterval cb, ms

  start: (seconds = 60) =>
    @seconds_left = seconds
    $("#timer").html(
      "<a href='#' class='btn btn-inverse btn-large top-button' id='times_up'>
        <div class='time-left'>#{@time_for(@seconds_left)}</div>
        <div class='end-early'>(Click to End Early)</div>
      </a>")
    @every 1000, () =>
      @tick()

  tick: =>
    @seconds_left = @seconds_left - 1
    $("#timer").html(
      "<a href='#' class='btn btn-inverse btn-large top-button' id='times_up'>
        <div class='time-left'>#{@time_for(@seconds_left)}</div>
        <div class='end-early'>(Click to End Early)</div>
      </a>")
    if @seconds_left <= 0
      @stop_timer()

  stop_timer: ->
    clearInterval(@interval)
    $("#timer").empty()


  time_for: (seconds) =>
    minutes = Math.floor(seconds / 60)
    seconds = seconds % 60
    seconds = "0#{seconds}" if seconds < 10
    "#{minutes}:#{seconds}"

window.Timer = Timer
