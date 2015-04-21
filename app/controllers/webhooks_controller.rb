require 'json'

class WebhooksController < ApplicationController

  skip_before_filter :verify_authenticity_token

  def receive
    event_json = JSON.parse(request.body.read)
    event = Stripe::Event.retrieve(event_json[:id])

    if event.type == 'invoice.payment_succeeded'
      #
    end

    if event.type == 'invoice.payment_failed'
      #
    end

    render status: :ok
  end

end