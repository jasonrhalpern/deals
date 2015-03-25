class BusinessesController < ApplicationController
  load_and_authorize_resource :except => [:profile]

  before_action :authenticate_user!, :except => [:profile]

  def new
    if current_user.business.present?
      redirect_to business_path(current_user.business)
    else
      @register_business = true
      @business = current_user.build_business
    end
  end

  def show
  end

  def create
    if @business.save
      redirect_to business_path(@business), notice: 'This business was successfully created.'
    else
      render action: "new"
    end
  end

  def edit
  end

  def update
    if @business.update_attributes(business_params)
      redirect_to business_path(@business), notice: 'This business was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @business.destroy
    redirect_to new_business_path, notice: 'This business was deleted.'
  end

  def profile
    @business = Business.includes(:category, :locations).where(:id => params[:id], :locations => {id: params[:lid]}).first
    @location_deals = LocationDeal.includes(:deal).where(:location_id => params[:lid])
    @other_locations = Location.where(:business_id => params[:id]).where.not(id: params[:lid])

    redirect_to root_path, :flash => { :error => 'This business was not found' } if @business.blank?
  end

  private

  def business_params
    params.require(:business).permit(:name, :website, :avatar, :category_id)
  end

end