module FavoritesHelper
  def delete_favorite_path(location, user)
    favorite = Favorite.where(location: location, user: user).first
    favorite_path(favorite)
  end

  def favorite_exists(favorite_locations, user, location, ajax_update)
    if favorite_locations.nil? || ajax_update
      user.has_favorite?(location)
    else
      favorite_locations.include?(location.id)
    end
  end

end