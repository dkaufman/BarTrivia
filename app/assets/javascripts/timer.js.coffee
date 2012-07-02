class Timer
  every: (ms, cb) =>
    @interval = setInterval cb, ms

  start: (seconds = 60) =>
    @seconds_left = seconds
    $("#timer").html(@time_for(@seconds_left))
    @every 1000, () =>
      @tick()

  tick: =>
    @seconds_left = @seconds_left - 1
    if @seconds_left <= 10 && @seconds_left > 0
      $("#timer").html("<div class='red'>#{@time_for(@seconds_left)}</div>")
    else if @seconds_left <= 0
      clearInterval(@interval)
      $("#times_up").click()
      $("#timer").empty()
    else
      $("#timer").html("<div>#{@time_for(@seconds_left)}</div>")

  time_for: (seconds) =>
    minutes = Math.floor(seconds / 60)
    seconds = seconds % 60
    seconds = "0#{seconds}" if seconds < 10
    "#{minutes}:#{seconds}"

window.Timer = Timer
