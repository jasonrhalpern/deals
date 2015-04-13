class PaymentsController < ApplicationController
  load_and_authorize_resource :business
  load_and_authorize_resource :payment, :through => :business, :singleton => true

  before_action :authenticate_user!

  def index
    if @payment.nil?
      redirect_to action: :new if @payment.nil?
    else
      @card_details = @payment.get_card
      @plan_details = @payment.get_plan
    end
  end

  def new
  end

  def create
    if @payment.save_with_plan
      redirect_to business_payments_path(@business), notice: 'This payment plan was successfully processed.'
    else
      flash[:error] = 'This payment plan could not be processed at this time. Please try again or send us an email.'
      render action: "new"
    end
  end

  def edit_card
  end

  def update_card
  end

  def edit_plan
  end

  def update_plan
  end

  def destroy
  end

  private

  def payment_params
    params.require(:payment).permit(:stripe_card_token, :stripe_plan_token)
  end

end