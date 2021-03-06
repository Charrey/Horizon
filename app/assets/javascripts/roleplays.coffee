# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
@select_character =(c) ->
  $("#submit_field")[0].disabled = false;
  $("#message_body")[0].disabled = false;
  if $("#character_id_field")[0].value == "-1"
    $("#message_body")[0].value = ""
  $("#character_id_field").val(c)
  for i in $(".character-card")
    i.classList.remove("dark-card", "text-white")
    i.classList.add("light-card")
  $("#card_for_" + c)[0].classList.add("dark-card","text-white")
  $("#card_for_" + c)[0].classList.remove("light-card")


@select_character_option =(c) ->
  optionarea = $("#options-area")
  form = $("#" + c + " > itsform")
  optionarea.empty()
  optionarea.append(form.clone())
  for i in $('.option-card')
    i.classList.remove("dark-card", "text-white")
  $('#option-card-for-' + c)[0].classList.add("dark-card", "text-white")
  $('.primary-card')[0].classList.remove("dark-card", "text-white")
  $('.primary-card')[0].classList.add("gray-card")


@select_roleplay_option = ->
  optionarea = $("#options-area")
  form = $("#roleplayform")
  optionarea.empty()
  optionarea.append(form.clone())
  for i in $('.option-card')
    i.classList.remove("dark-card", "text-white")
  $('.primary-card')[0].classList.add("dark-card", "text-white")

jQuery(document).on 'turbolinks:load', ->
  #if there are any messages that need to be loaded into the messages screen AND THIS HAS NOT ALREADY BEEN DONE
  if $('#roleplays_show .messagetobeadded').length > 0 && $('#messages .card').length == 0
    previous_from = null
    previous_message = null
    for message in $(".messagetobeadded")
      window.process(message)
      previous_from = $("message-from", message)[0].textContent
    window.scrollToBottom()
    if $('.character-card').length > 0
      $('.character-card')[0].click()


jQuery(document).on 'turbolinks:load', ->
  if $('#roleplays_edit').length > 0
    switch getURLParameter("result")
      when "success"
        switch getURLParameter("reason")
          when "saved"
            c = getURLParameter("selected")
            if c > 0
              name = $("#" + c + " > name")[0].textContent
              $("#notice-alert-container").append("<div class=\"alert alert-success\">Options saved for <strong>" + name + "</strong>.</div>")
            else if c == "-1"
              $("#notice-alert-container").append("<div class=\"alert alert-success\">General roleplay options saved.</div>")
            else
              console.error("unknown \"selected\" parameter")
          when "deleted"
            $("#notice-alert-container").append("<div class=\"alert alert-success\">Successfully deleted character.</div>")
          when "created"
            $("#notice-alert-container").append("<div class=\"alert alert-success\">Successfully created character.</div>")
          else
            console.error("unknown \"reason\" parameter")
      when "fail"
        switch getURLParameter("reason")
          when "nochanges"
            $("#notice-alert-container").append("<div class=\"alert alert-warning\">No changes were detected.</div>")
          when "nosuchuser"
            $("#notice-alert-container").append("<div class=\"alert alert-danger\">That user doesn't exist!</div>")
          else
            console.error("unknown \"reason\" parameter")
      else
        console.error("unknown \"result\" parameter")

    if c > 0
      select_character_option(c)
    else
      select_roleplay_option()


window.process =(data, previous_from = null) ->
  messagetype = $("message-type", data)[0].textContent
  image = $("message-image", data)[0].outerHTML
  from = $("message-from", data)[0].textContent
  content = $("message-content", data)[0].textContent
  switch messagetype
    when "message"

      previous_message = $('#messages > .message-entry:last sender')
      if previous_message.length > 0
        previous_from = $('#messages > .message-entry:last sender')[0].textContent
      if from == previous_from
          $('#messages > .message-card:last .text-container').append("<br>" + content)
      else
        $('#messages').append(
          "<div class=\"card light-card rounded message-card message-entry\">\n" +
            "  <sender hidden>" + from + "</sender>" +
            "  <div class=\"card-block\">\n" +
            "    <div class=\"row\">\n" +
            "      <div class=\"col-1\">\n" +
            image +
            "      </div>\n" +
            "      <div class=\"col-11\">\n" +
            "        <p class=\"card-text text-container\">\n" +
            "          <span class=\"text-muted\">" + from + " says</span><br>\n" +
            "           " + content + "\n" +
            "        </p>\n" +
            "      </div>\n" +
            "    </div>\n" +
            "  </div>\n" +
            "</div>"
        )
    when "announcement"
      $('#messages').append(
        "<div class=\"rounded annoucement-card message-entry my-4\">\n" +
        content + "\n" +
        "</div>"
      )


    else console.error("Unknown message type: " + messagetype)