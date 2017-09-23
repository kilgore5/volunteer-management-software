# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'turbolinks:load', ->
  $('.js-add-card').click ->
    $('.js-payment-form').toggleClass('hidden')

  $ ->
    $('[data-toggle="tooltip"]').tooltip()
    return

jQuery ($) ->
  $('.js-payment-form').submit (event) ->
    $form = $(this)
    console.log("____SUBMITTED_____")
    # Disable the submit button to prevent repeated clicks
    $form.find('button').prop 'disabled', true
    Stripe.card.createToken $form, stripeResponseHandler
    # Prevent the form from submitting with the default action
    false
  return

stripeResponseHandler = (status, response) ->
  $form = $('.js-payment-form')
  if response.error
    # Show the errors on the form
    $form.find('.payment-errors').text response.error.message
    $form.find('button').prop 'disabled', false
  else
    # response contains id and card, which contains additional card details
    token = response.id
    # Insert the token into the form so it gets submitted to the server
    $form.append $('<input type="hidden" name="stripeToken" />').val(token)
    # and submit
    $form.get(0).submit()
  return