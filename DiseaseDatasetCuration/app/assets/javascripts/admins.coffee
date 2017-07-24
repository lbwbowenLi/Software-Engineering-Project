# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "page:change", ->
  $('#submitBtn').click ->
    $('#updateForm').submit()
    return
  # clear radio button
  $('.btn_clear').click ->
    id = this.id
    $('#choose_' + id + '_1').prop 'checked', false
    $('#choose_' + id + '_0').prop 'checked', false
    $('#reason_' + id).val("0")
    $('#reason_' + id).prop 'disabled', true
    return


  $('#submit').click ->
    has_error = false

    $('.radio_input').each (i, obj) ->
      id = this.id
      disease_id = id.substring(7, id.length-2)
      reason_id = "reason_" + disease_id
      if id[id.length-1] == '0' && $(this).is(':checked') && $('#'+reason_id).val().length == 0
        alert("Please choose reason for unrelated relationships.")
        has_error = true
        return false; # break
      return

    if has_error == false
      $('#questions').submit()
    return

  # make the drop down list selectable
  $('.radio_input').click ->
    id = this.id
    disease_id = id.substring(7, id.length-2)
    if id[id.length-1] == '0'
      $('#reason_' + disease_id).prop 'disabled', false
    return

  $('#query').on 'keypress', (e) ->
    code = if e.keyCode then e.keyCode else e.which
    if code == 13
      e.preventDefault()
      e.stopPropagation()
      $(this).closest('#query_form').submit()
      return

  $('#query_user').on 'keypress', (e) ->
    code = if e.keyCode then e.keyCode else e.which
    if code == 13
      e.preventDefault()
      e.stopPropagation()
      $(this).closest('#query_user_form').submit()
      return


  exportTableToCSV = ($table, filename) ->
    $rows = $table.find('tr:has(td)')
    tmpColDelim = String.fromCharCode(11)
    tmpRowDelim = String.fromCharCode(0)
    colDelim = '"\u0009"'
    rowDelim = '"\u000d\n"'
    csv = '"' + $rows.map((i, row) ->
      $row = $(row)
      $cols = $row.find('td')
      $cols.map((j, col) ->
        $col = $(col)
        text = $col.text()
        text.replace /"/g, '""'
        # escape double quotes
      ).get().join tmpColDelim
    ).get().join(tmpRowDelim).split(tmpRowDelim).join(rowDelim).split(tmpColDelim).join(colDelim) + '"'
    csvData = 'data:application/csv;charset=utf-8,' + encodeURIComponent(csv)
    $(this).attr
      'download': filename
      'href': csvData
      'target': '_blank'
    return

  $('.export').on 'click', (event) ->
    # CSV
    exportTableToCSV.apply this, [
      $('#dvData')
      'export.csv'
    ]
    # IF CSV, don't do event.preventDefault() or return false
    # We actually need this to be a typical hyperlink
    return

return
