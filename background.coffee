load_defaults = =>
  message("onInstall loading defaults")
  chrome.storage.sync.get 'jose.buttons', (data) ->
    unless data["jose.buttons"]
      chrome.storage.sync.set({"jose.buttons": DEFAULT_BUTTONS}, message("Default settings set"))
      message("Default buttons are saved")

message = (msg) =>
  console.log("prefs.js - #{msg}")

DEFAULT_BUTTONS = [
    title: "Sample app"
    text: 'Can you please provide a sample application that reproduces the error?'
    closable: true
  ,
    title: "Wiki"
    text: "The wiki is maintained by the community. So if there aren't any up to date instructions, we recommend you to explore the solution yourself and hopefully contribute your findings back!"
  ,
    title: "ML"
    text: "Please use the mailing list or StackOverflow for questions"
  ,
    title: "Bad bug report"
    text: "You need to give us more information on how to reproduce this issue, otherwise there is nothing we can do. Please read CONTRIBUTING.md file for more information about creating bug reports. Thanks!"
  ,
    title: "<img src='https://a248.e.akamai.net/assets.github.com/images/icons/emoji/shipit.png' width='14' height='14'>"
    text: ":shipit:"
    closable: false
  ,
    title: "<img src='https://a248.e.akamai.net/assets.github.com/images/icons/emoji/heart.png' width='14' height='14'>"
    text: ":heart: :green_heart: :blue_heart: :yellow_heart: :purple_heart:"
    closable: false
]

chrome.runtime.onInstalled.addListener(load_defaults())
