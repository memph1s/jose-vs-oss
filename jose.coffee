commentForm = document.querySelector '.js-new-comment-form'

selectElements = =>
  @actions        = commentForm.querySelector '.form-actions'
  @bubblesContent = document.querySelectorAll '.discussion-bubble.js-comment-container'
  @bubble         = @bubblesContent[@bubblesContent.length - 1]
  @close          = @actions.querySelector '.js-comment-and-button'
  @comment        = @actions.querySelector '.primary'
  @textarea       = commentForm.querySelector 'textarea'

if commentForm
  do selectElements

  MutationObserver = WebKitMutationObserver or MozMutationObserver

  observer = new MutationObserver (mutations) ->
    mutations.forEach (mutation) ->
      do selectElements

  observer.observe @actions, childList: true

  button = (text, innerHtml, closable = true) =>
    btn = document.createElement 'button'

    btn.innerHTML = text
    btn.className = 'button'
    btn.setAttribute 'tabindex', '1'
    btn.setAttribute 'type', 'submit'
    btn.setAttribute 'title', innerHtml
    btn.setAttribute 'style', 'margin-right: 4px;'

    btn.addEventListener 'click', (event) =>
      do event.preventDefault
      @textarea.value = innerHtml

      if closable then do @close.click else do @comment.click

      @textarea.value = ''

    btn

  insert_buttons = =>
    chrome.storage.sync.get('jose.buttons', (data) ->
      buttons = data["jose.buttons"]
      load_buttons(buttons))

  load_buttons = (buttons = []) =>
    div = document.createElement 'div'
    div.setAttribute 'style', 'float: left; margin: -40px 0px 0px 60px;'

    for b in buttons
      btn = button b.title, b.text, b.closable
      div.appendChild btn

    @bubble.appendChild div

  do insert_buttons if commentForm && @close
