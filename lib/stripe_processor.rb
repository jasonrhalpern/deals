module StripeProcessor

  def process_invoice_success(invoice)
    payment = load_payment(invoice.customer, invoice.subscription)
    subscription = invoice.lines.data.detect { |line| line['id'] == invoice.subscription }
    payment.extend_active_until(subscription.plan.interval) if subscription.present?
    #email user
  end

  def process_invoice_failure(invoice)
    payment = load_payment(invoice.customer, invoice.subscription)
    payment.deactivate
    #email user
  end

  def load_payment(customer_token, subscription_token)
    Payment.where(stripe_cus_token: customer_token, stripe_sub_token: subscription_token).first
  end

end