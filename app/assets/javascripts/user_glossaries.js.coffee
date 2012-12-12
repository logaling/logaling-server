copy_block = (i) ->
  increament_id = (class_name, i) ->
    $("#term" + i).children("." + class_name).attr "id", class_name + i

  target = $("#term" + (i - 1))
  target.clone().insertAfter(target).attr "id", "term" + i
  increament_id "glossary_entry_source_term", i
  increament_id "glossary_entry_target_term", i
  increament_id "glossary_entry_note", i
  $("#glossary_entry_source_term" + i).val ""
  $("#glossary_entry_target_term" + i).val ""
  $("#glossary_entry_note" + i).val ""

$ ->
  $("#add_btn").click ->
    i = 1
    i++  until $("#term" + i).length is 0
    copy_block i
