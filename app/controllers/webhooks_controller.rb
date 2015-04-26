require 'json'

class WebhooksController < ApplicationController
  include StripeProcessor

  skip_before_filter :verify_authenticity_token

  def receive
    event_json = JSON.parse(request.body.read)
    event = Stripe::Event.retrieve(event_json['id'])
    process_invoice_success(event.data.object) if event.type == 'invoice.payment_succeeded'
    process_invoice_failure(event.data.object) if event.type == 'invoice.payment_failed'

    head :ok
  end

end