class DealsController < ApplicationController
  load_and_authorize_resource :business
  load_and_authorize_resource :deal, :through => :business

  before_action :authenticate_user!

  def index
    @deals = @deals.includes(:locations)
    if params[:lid].present?
      deal_ids = @deals.where(:locations => { :id => params[:lid]}).pluck(:id)
      @deals = @deals.where(id: deal_ids)
    end
  end

  def new
  end


  def create
    authorize_locations(params[:deal][:location_ids])
    if @deal.save
      redirect_to business_deals_path(@business), notice: 'This deal was successfully added.'
    else
      render action: "new"
    end
  end

  def edit
  end

  def update
    authorize_locations(params[:deal][:location_ids])
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

  def authorize_locations(location_ids)
    if location_ids.present?
      location_ids.each do |id|
        if id.present?
          location = Location.find(id)
          authorize! :read, location
        end
      end
    end
  end

  def deal_params
    params.require(:deal).permit(:status, :description, :start_date, :end_date, :monday, :tuesday,
                                :wednesday, :thursday, :friday, :saturday, :sunday, :location_ids => [])
  end

end