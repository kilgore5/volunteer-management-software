json.extract! event, :id, :start_time, :end_time, :event_length, :ticket_price_cents, :client_owner_id, :created_at, :updated_at
json.url event_url(event, format: :json)
