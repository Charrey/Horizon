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
    i.classList.remove("bg-dark", "text-white")
    i.classList.add("bg-light")
  $("#card_for_" + c)[0].classList.add("bg-dark","text-white")
  $("#card_for_" + c)[0].classList.remove("bg-light")


@select_character_option =(c) ->
  optionarea = $("#options-area")
  form = $("#" + c + " > itsform")
  optionarea.empty()
  optionarea.append(form.clone())
  for i in $('.option-card')
    i.classList.remove("bg-dark", "text-white")
  $('#option-card-for-' + c)[0].classList.add("bg-dark", "text-white")
  $('.primary-card')[0].classList.remove("bg-dark", "text-white")
  $('.primary-card')[0].classList.add("bg-secondary")


@select_roleplay_option = ->
  optionarea = $("#options-area")
  form = $("#roleplayform")
  optionarea.empty()
  optionarea.append(form.clone())
  for i in $('.option-card')
    i.classList.remove("bg-dark", "text-white")
  $('.primary-card')[0].classList.add("bg-dark", "text-white")

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


