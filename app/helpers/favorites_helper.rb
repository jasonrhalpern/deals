module FavoritesHelper
  def delete_favorite_path(location, user)
    favorite = Favorite.where(location: location, user: user).first
    favorite_path(favorite)
  end
end