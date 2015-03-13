class DealsController < ApplicationController
  load_and_authorize_resource :business
  load_and_authorize_resource :deal, :through => :business

  before_filter :authenticate_user!

  def index
  end

  def new
  end


  def create
    if @deal.save
      redirect_to business_deals_path(@business), notice: 'This deal was successfully added.'
    else
      render action: "new"
    end
  end

  def edit
  end

  def update
    if @deal.update_attributes(deal_params)
      redirect_to business_deals_path(@business), notice: 'This deal was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @deal.destroy
    redirect_to business_deals_path(@business), notice: 'This deal was deleted.'
  end

  private

  def deal_params
    params.require(:deal).permit(:status, :description, :start_date, :end_date, :monday, :tuesday,
                                :wednesday, :thursday, :friday, :saturday, :sunday)
  end

end