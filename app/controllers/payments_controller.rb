class PaymentsController < ApplicationController
  load_and_authorize_resource :business
  load_and_authorize_resource :payment, :through => :business, :singleton => true

  before_action :authenticate_user!

  def new
  end

  def create
  end

  def show
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