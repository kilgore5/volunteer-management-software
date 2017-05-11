## Pseudocode // Not even

# => :volunteer will be required to input valid credit card details on signup
# => card should be valid until after the festival
# => before each new Event, they must update their card details ? 
  # => or only if the card is going to expire ?


## The Stripe Account

# => Each festival should be onboarded with a Stripe Account
# => This will require Stripe Connect integration, creata account via the API for each new festival
  # => The Event is responsible for confirming their account with Stripe.
  # => Event should not be active until Stripe is fully enabled for the Event.
  # => 