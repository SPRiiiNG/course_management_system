# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->

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

  set_subject_select = () ->
    course_subject = JSON.parse($('#course_subject').val())
    default_subject = ''
    if course_subject
      default_subject = course_subject._id.$oid

    category = $('#category_select').val()
    $('#subject_select').empty()
    $.each categories_subjects_hash[category]['subjects'], (index, value) ->
      select_attr = ''
      select_attr = 'selected="selected"' if value['id'] == default_subject 
      select_element = '<option value="'+value['id']+'" '+select_attr+' >'+value['name']+'</option>'
      $('#subject_select').append(select_element)
      return
    $('.selectpicker').selectpicker('refresh');

  categories_subjects_hash = JSON.parse($('#categories_subjects_hash').val())
  set_subject_select()

  $('#category_select').on 'change', () ->
    set_subject_select()
