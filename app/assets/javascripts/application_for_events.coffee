# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'turbolinks:load', ->
  $('.star-rating').raty
    path: '/assets/'
    score: ->
      $(this).attr 'data-score'
    scoreName: 'application_for_event[rating]'
  $('.star-rating').raty 'reload'

$(document).on 'turbolinks:load', ->
  $('.star-rating img').click ->
    form = $(this).closest('form')[0]
    Rails.fire form, 'submit'
    return

  $('#job_slug').change ->
    form = $(this).closest('form')[0]
    form.submit()
    return

