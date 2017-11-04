# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'turbolinks:load', ->
  $("a[data-rotation]").on "ajax:success", (e, data, status, xhr) ->
    $('#' + $(this).attr("data-rotation")).slideUp()
    $('.alert').removeClass('show')
    $('.alert .alert-message').html('Rotation was deleted!')
    setTimeout ->
      $('.alert').addClass('show')
    , 700

