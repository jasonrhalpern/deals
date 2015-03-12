class LocationsController < ApplicationController
  load_and_authorize_resource :business
  load_and_authorize_resource :location, :through => :business

  before_filter :authenticate_user!

  def index
  end

  def new
  end


  def create
    if @location.save
      redirect_to business_locations_path(@business), notice: 'This location was successfully added.'
    else
      render action: "new"
    end
  end

  def edit
  end

  def update
    if @location.update_attributes(location_params)
      redirect_to business_locations_path(@business), notice: 'This location was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @location.destroy
    redirect_to business_locations_path(@business), notice: 'This location was deleted.'
  end

  private

  def location_params
    params.require(:location).permit(:street, :city, :state, :zip_code, :phone_number)
  end

end