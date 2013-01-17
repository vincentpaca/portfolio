command_list = [

  { name: "help", single: true, results:
                                  [
                                    "info",
                                    "grep [ skills | projects ]",
                                    "wget"
                                  ] },
  { name: "grep", single: false, sub_commands: ["skills", "projects"] }
]

Array::toDict = (key) ->
  @reduce ((dict, obj) -> dict[ obj[key] ] = obj if obj[key]?; return dict), {}

dictionary = command_list.toDict('name')

resize = ->
  $(".content").width($(window).width() - 15)
  $(".content").height($(window).height() - 15)

$(window).resize ->
  resize()

$(document).ready ->
  resize()
  $("#input").focus()

$(document).keyup (e) ->
  unless e.keyCode == 8
    char = String.fromCharCode(e.which).toLowerCase()
    $("#input").append("<span>" + char + "</span>")

$(document).keydown (e) ->
  if e.keyCode == 8
    e.preventDefault()
    $("#input").children("span:last").remove()

  if e.keyCode == 13
    e.preventDefault()
    command = $("#input").find('span').remove()
    execute(command.text().replace(/^\s+|\s+$/g, ""))

execute = (command) ->
  # append command
  append(command, "normal")
  lang = command.split(" ")

  if typeof(dictionary[lang[0]]) == 'undefined'
    append(command, "error")
  else
    if dictionary[lang[0]]["single"]
      if lang.length > 1
        append(command, "invalid_params")
      else
        append(lang[0], "result")
    else
      append(command, "result")


append = (command, type) ->
  switch(type)
    when "normal"
      $(".console").append("<div class='line normal'>root@localhost:~/home$ " + command + "</div>")
    when "result"
      $(".console").append("<div class='margin result'>" + "t0d0" + "</div>")
    when "invalid_params"
      $(".console").append("<div class='line error'>No topics match '" + command + "'. Type 'help' for a list of commands.</div>")
    else
      $(".console").append("<div class='line error'>'" + command + "' is not the command you are looking for.</div>")
