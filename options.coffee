load_options = =>
  @main_div = document.getElementById('options-form')

  chrome.storage.sync.get "jose.buttons", (data) ->
      buttons = data["jose.buttons"]
      load_buttons(buttons)

load_buttons = (buttons = []) =>
  for button in buttons
    add_button button['title'], button['text'], button['closable']

add_button = (title = "", text = "", closable = false) =>
  div = document.createElement 'div'
  div.setAttribute("class", "button")
  el = document.createElement 'label'
  el.innerHTML = "Title:"
  div.appendChild el
  el = document.createElement 'input'
  el.setAttribute("class", "title")
  el.value = title
  div.appendChild el
  el = document.createElement 'textarea'
  el.setAttribute("class", "text")
  el.value = text
  div.appendChild el
  el = document.createElement 'input'
  el.setAttribute("class", "closable")
  el.type = 'checkbox'
  el.checked = closable
  div.appendChild el
  el = document.createElement 'a'
  el.setAttribute("class", "delete_button")
  el.setAttribute('href', '#')
  el.innerHTML = 'remove'
  div.appendChild el
  @main_div.appendChild div

add_empty_button = =>
  add_button()

save_options = =>
  buttons = []
  nodes = $('.button')
  for node in nodes
    title = $(node).find(".title").val()
    text = $(node).find(".text").val()
    closable = $(node).find(".closable").prop('checked')

    b = {title: title, text: text, closable: closable}
    buttons.push b

  chrome.storage.sync.set({"jose.buttons": buttons}, message("Settings saved"))

message = (msg) =>
  console.log("options.js - #{msg}")

$ ->
  load_options()

  $("#add_button").click ->
    add_empty_button()

  $("#save_options").click ->
    save_options()

  $(document).on 'click', '.delete_button', ->
    $(this).parent().remove()
    false
