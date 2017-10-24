jQuery ($) ->
  $('.application_form').submit (event) ->
    debugger
    $form = $(this)
    console.log("____SUBMITTED_____")
    # Disable the submit button to prevent repeated clicks
    $form.find('button').prop('disabled', true).addClass('loading')
    Stripe.card.createToken $form, stripeResponseHandler
    # Prevent the form from submitting with the default action
    false
  return

stripeResponseHandler = (status, response) ->
  $form = $('.application_form')
  if response.error
    # Show the errors on the form
    $form.find('.payment-errors').text response.error.message
    $form.find('button').prop('disabled', false).removeClass('loading')
  else
    # response contains id and card, which contains additional card details
    token = response.id
    # Insert the token into the form so it gets submitted to the server
    $form.append $('<input type="hidden" name="stripeToken" />').val(token)
    # and submit
    $form.get(0).submit()
  return