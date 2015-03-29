class FavoritesController < ApplicationController

  before_action :authenticate_user!

  def index

  end

  def create
    @favorite = Favorite.new(location_id: params[:location_id], user_id: current_user.id)
    authorize! :create, @favorite
    respond_to do |format|
      if @favorite.save
        format.js { render :toggle }
      end
    end
  end

  def destroy
    @favorite = Favorite.find(params[:id])
    authorize! :destroy, @favorite
    respond_to do |format|
      if @favorite.destroy
        format.js { render :toggle }
      end
    end
  end

  private

  def favorite_params
    params.require(:favorite).permit(:user_id, :location_id)
  end

end