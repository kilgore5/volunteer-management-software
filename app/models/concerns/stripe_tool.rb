module StripeTool
  def self.create_customer(email: email, stripe_token: stripe_token)
    Stripe::Customer.create(
      email: email,
      source: stripe_token
    )
  end

  def self.create_membership(email: email, stripe_token: stripe_token, plan: plan)
    Stripe::Customer.create(
      email: email,
      source: stripe_token,
      plan: plan
    )
  end

  def self.create_charge(customer_id, amount, description)
    begin
      # Create it in Stripe
      Stripe::Charge.create(
        customer: customer_id,
        amount: amount,
        description: description,
        currency: 'aud'
      )
    rescue Stripe::CardError => e
      # Since it's a decline, Stripe::CardError will be caught
      body = e.json_body
      err  = body[:error]
      #Generic Error
      return {error: err}
    rescue Stripe::StripeError => e
      # Display a very generic error to the user, and maybe send
      # yourself an email
      body = e.json_body
      err  = body[:error]
      return {error: err}
    rescue => e
      return {error: e}
    end
  end
end