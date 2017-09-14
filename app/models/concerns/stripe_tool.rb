module StripeTool
  def self.create_customer(email, stripe_token)
    Stripe::Customer.create(
      email: email,
      source: stripe_token
    )
  end

  def self.add_card(customer, stripe_token)
    # Revise this to add multiple sources
    customer.source = stripe_token
    customer.save
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

  def self.find_customer(stripe_id)
    begin
      # Find Customer
      Stripe::Customer.retrieve(
        stripe_id
      )
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