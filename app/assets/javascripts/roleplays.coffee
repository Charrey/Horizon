# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
@select_character =(c) ->
  $("#submit_field")[0].disabled = false;
  $("#character_id_field").val(c)
  cards = $(".character-card")
  for i in cards
    i.classList.remove("selected")
  $("#card_for_" + c)[0].classList.toggle("selected")
  console.log($("#card_for_" + c)[0].classList)