$(".content").cssConsole()

resize = ->
  $(".content").width($(window).width() - 10)
  $(".content").height($(window).height() - 10)

$(window).resize ->
  resize()

$(document).ready ->
  resize()

  addLine = (input, style, color) ->
    $(".console div").eq(0).remove()  if $(".console div").length is lineLimit
    style = (if typeof style isnt "undefined" then style else "line")
    color = (if typeof color isnt "undefined" then color else "green")
    $(".console").append "<div class=\"" + style + " " + color + "\">" + input + "</div>"

  execCommand = (command) ->
    w = command.split(" ")
    if w.length == 2
      if commands[w[1]]
        commands[w[1]]()
      else
        addLine "'" + command + "' is not the command you were looking for.", "line", "red"
    else
      if commands[command]
        commands[command]()
      else
        addLine "'" + command + "' is not the command you were looking for.", "line", "red"

  $("#input").cssConsole
    inputName: "console"
    charLimit: 60
    onEnter: ->
      addLine "$ " + $("#input").find("input").val()
      execCommand $("#input").find("input").val()
      $("#input").cssConsole "reset"

  lineLimit = 28
  focus = undefined

  focus = window.setInterval(->
    $("#input").find("input").focus()  unless $("#input").find("input").is(":focus")
  , 100)

  commands =
    help: ->
      addLine "Available command list:", "line", "blue"
      addLine "help", "margin", "blue"
      addLine "describe", "margin", "blue"
      addLine "grep [ skills | tools | projects ]", "margin", "blue"

    describe: ->
      addLine "", "margin", "blue"

    grep: ->
      addLine "grep what? Are you looking for something?", "line", "red"

    skills: ->
      addLine "Listing skills:", "line", "blue"
      addLine "Ruby ----------------- 9/10", "margin", "blue"
      addLine "Rails ---------------- 9/10", "margin", "blue"
      addLine "Javascript, jQuery --- 9/10", "margin", "blue"
      addLine "SQL (PGSQL, MySQL) --- 9/10", "margin", "blue"
      addLine "CSS, HTML ------------ 9/10", "margin", "blue"
      addLine "*nix Servers --------- 8/10", "margin", "blue"
      addLine "Guitar --------------- 8/10", "margin", "blue"
      addLine "Beer Drinking -------- 9001/10, yes, you read that right.", "margin", "blue"
