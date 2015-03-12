class BusinessesController < ApplicationController
  load_and_authorize_resource

  before_filter :authenticate_user!

  def new
    @business = current_user.build_business
  end

  def show
    redirect_to action: :new if current_user.business.nil?
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

  private

  def business_params
    params.require(:business).permit(:name, :website, :avatar, :category_id)
  end

end