jQuery(document).on 'turbolinks:load', ->
  if document.getElementById("roleplays show")
    messages = $('#messages')
    if $('#messages').length > 0


      App.global_chat = App.cable.subscriptions.create {
        channel: "RoleplaysChannel"
        roleplay_id: messages.data('roleplay-id')
      },
        connected: ->
  # Called when the subscription is ready for use on the server

        disconnected: ->
          App.global_chat.unsubscribe()

        received: (data) ->
          messages.append(data)
          console.log(data)


        send_message: (message, roleplay_id) ->
          @perform 'send_message', message: message, roleplay_id: roleplay_id


      $('#new_message').submit (e) ->
        $this = $(this)
        textarea = $this.find('#message_body')
        e.preventDefault()

        if $.trim(textarea.val()).length > 1
          App.global_chat.send_message textarea.val(), messages.data('roleplay-id')
          textarea.val('')

        return false
  else if App.global_chat # if I'm not on the page where I want to be connected, unsubscribe and set it to null
    App.global_chat.unsubscribe()
    App.global_chat = null;