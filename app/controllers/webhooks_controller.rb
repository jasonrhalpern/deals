require 'json'

class WebhooksController < ApplicationController

  skip_before_filter :verify_authenticity_token

  def receive
    event_json = JSON.parse(request.body.read)
    event = Stripe::Event.retrieve(event_json[:id])
    payment = Payment.where(stripe_cus_token: event.customer, stripe_sub_token: event.subscription)

    if event.type == 'invoice.payment_succeeded'
      subscription = event.data.object.lines.subscriptions[0]
      payment.extend_active_until(subscription.plan.interval)
      payment.save!
      #emmail user
    end
    if event.type == 'invoice.payment_failed'
      payment.deactivate
      #emmail user
    end

    render status: :ok
  end

end