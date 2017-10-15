jQuery(document).on 'turbolinks:load', ->
  messages = $('#messages')
  if $('#messages').length > 0
    App.global_chat = App.cable.subscriptions.create {
      channel: "RoleplaysChannel"
      roleplay_id: messages.data('roleplay-id')
    },
      connected: ->
# Called when the subscription is ready for use on the server

      disconnected: ->


      received: (data) ->
        shouldScroll = messages.scrollTop + messages.clientHeight == messages.scrollHeight;
        window.process(data)
        if (!shouldScroll)
          window.scrollToBottom()

      send_message: (message, roleplay_id, character_id) ->
        @perform 'send_message', message: message, roleplay_id: roleplay_id, character_id: character_id

    $('#new_message').submit (e) ->
      $this = $(this)
      textarea = $this.find('#message_body')
      e.preventDefault()

      if $.trim(textarea.val()).length > 1
        App.global_chat.send_message textarea.val(), messages.data('roleplay-id'), $("#character_id_field").val()
        textarea.val('')

      return false




window.scrollToBottom = ->
  messages.scrollTop = messages.scrollHeight;
