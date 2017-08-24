# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
#   # JSON.parse('<%= @link.errors.messages.to_json.html_safe%>')
#   # chart_data_row = '<%= "#{@chart_data_row.to_json}" %>'
#
#   show_date = JSON.parse($('#start_time').val()).split(" ")[0]
#   if $('#start_time').val().split("/")[0] != $('#end_time').val().split("/")[0]
#     show_date = show_date+" - "+JSON.parse($('#end_time').val()).split(" ")[0]
#
  currentdate = new Date
  cur_date = (currentdate.getMonth()+1)+"/"+currentdate.getDate()+"/"+currentdate.getFullYear()

  $('#datetimepicker_start').datetimepicker
    format: 'DD/MM/YYYY HH:mm',
    defaultDate: cur_date+ " 10:00"
  $('#datetimepicker_end').datetimepicker
    useCurrent: false,
    format: 'DD/MM/YYYY HH:mm',
    defaultDate: cur_date+ " 23:59"

  $('#datetimepicker_start').on 'dp.change', (e) ->
    $('#datetimepicker_end').data('DateTimePicker').minDate e.date
    if $('#start_time').val() > $('#end_time').val()
      $('#end_time').val($('#start_time').val())
    setup_attr()
    return

  $('#datetimepicker_end').on 'dp.change', (e) ->
    $('#datetimepicker_start').data('DateTimePicker').maxDate e.date
    setup_attr()
    return

  setup_attr = () ->
    course_name = $('#course_name').val()
    $('#btn-search').attr("href","/courses?course_name=" + course_name.toString())

  setup_attr()
  $('#course_name').on 'change', () ->
    setup_attr()
