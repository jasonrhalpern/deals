class PaymentsController < ApplicationController
  load_and_authorize_resource :business
  load_and_authorize_resource :payment, :through => :business, :singleton => true, :except => [:edit_card, :update_card, :edit_plan, :update_plan]

  before_action :authenticate_user!
  before_action :set_payment, only: [:edit_card, :update_card, :edit_plan, :update_plan]

  def index
    if @payment.nil?
      redirect_to action: :new if @payment.nil?
    else
      @card = @payment.get_card
      @plan = @payment.get_plan
    end
  end

  def new
    if Payment.exists?(:business_id => @business.id)
      redirect_to action: :index
    end
  end

  def create
    if @payment.save_with_plan
      redirect_to business_payments_path(@business), notice: 'This payment plan was successfully processed.'
    else
      flash[:error] = 'This payment plan could not be processed at this time. Please try again or send us an email.'
      render action: 'new'
    end
  end

  def edit_card
    authorize! :edit_card, @payment
    @card = @payment.get_card
  end

  def update_card
    authorize! :update_card, @payment
    if @payment.update_card(params[:payment][:stripe_card_token])
      redirect_to business_payments_path(@business), notice: 'The credit card was successfully updated.'
    else
      flash[:error] = 'This credit card could not be updated at this time. Please try again or send us an email.'
      render action: 'edit_card'
    end
  end

  def edit_plan
    authorize! :edit_plan, @payment
    @plan = @payment.get_plan
  end

  def update_plan
    authorize! :update_plan, @payment
    if @payment.update_plan(params[:payment][:stripe_plan_token])
      redirect_to business_payments_path(@business), notice: 'This payment plan was successfully updated.'
    else
      flash[:error] = 'This payment plan could not be updated at this time. Please try again or send us an email.'
      render action: 'edit_plan'
    end
  end

  def destroy
    @payment.cancel
    redirect_to business_payments_path(@business)
  end

  private

  def payment_params
    params.require(:payment).permit(:stripe_card_token, :stripe_plan_token)
  end

  def set_payment
    @payment = Payment.find(params[:id])
  end

end