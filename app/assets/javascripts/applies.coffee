# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'turbolinks:load', ->
  $('.star-rating').raty
    path: '/assets/'
    score: ->
      $(this).attr 'data-score'
    scoreName: 'apply[rating]'
  $('.star-rating').raty 'reload'

$(document).on 'turbolinks:load', ->
  $('.star-rating img').click ->
    id = $(this).parent().attr 'data-id'
    form = $("#edit_apply_" + id)[0]
    input = $(this).parent().find('input[name="apply[rating]"]')[0]
    form.append(input)
    Rails.fire form, 'submit'
    return

  $('#job_slug').change ->
    form = $(this).closest('form')[0]
    form.submit()
    return

  $('#select_all_accept').change ->
    if $(this).is(':checked')
      $('input[name="application_ids_accept[]"]:not([disabled])').prop('checked', true);
      $('input[name="application_ids_deny[]"]:not([disabled])').prop('checked', false);
      $('input[name="select_all_deny"]').prop('checked', false);
    else
      $('input[name="application_ids_accept[]"]:not([disabled])').prop('checked', false);

  $('#select_all_deny').change ->
    if $(this).is(':checked')
      $('input[name="application_ids_deny[]"]:not([disabled])').prop('checked', true);
      $('input[name="application_ids_accept[]"]:not([disabled])').prop('checked', false);
      $('input[name="select_all_accept"]').prop('checked', false);
    else
      $('input[name="application_ids_deny[]"]:not([disabled])').prop('checked', false);

  $('input[name="application_ids_deny[]"]:not([disabled])').change ->
    if $(this).is(':checked')
      console.log($(this).val())
      $("input[value='" + $(this).val() + "'][name='application_ids_accept[]']:not([disabled])").prop('checked', false);

  $('input[name="application_ids_accept[]"]:not([disabled])').change ->
    if $(this).is(':checked')
      console.log($(this).val())
      $("input[value='" + $(this).val() + "'][name='application_ids_deny[]']:not([disabled])").prop('checked', false);
