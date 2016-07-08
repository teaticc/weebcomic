class FavoritesController < ApplicationController

  def create
    Favorite.create(user_id: current_user.id, comic_id: params[:comic_id])
    redirect_to :root
  end

  def destroy
    dislike = Favorite.where(user_id: current_user.id, comic_id: params[:id])
    Favorite.destroy(dislike)
    redirect_to :root
  end
end
