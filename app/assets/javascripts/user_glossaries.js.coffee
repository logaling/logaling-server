copy_block = (i) ->
  increament_id = (class_name, i) ->
    $("#term" + i).children("." + class_name).
    attr("name", "glossary_entry[" + i + "][" + class_name + "]").
    attr("id", class_name + i)

  target = $("#term" + (i - 1))
  target.clone().insertAfter(target).attr "id", "term" + i

  increament_id "source_term", i
  increament_id "target_term", i
  increament_id "note", i

  $("#source_term" + i).val ""
  $("#target_term" + i).val ""
  $("#note" + i).val ""
  $(".text-error").text ""

$ ->
  $("#add_btn").click ->
    i = 1
    i++  until $("#term" + i).length is 0
    copy_block i
