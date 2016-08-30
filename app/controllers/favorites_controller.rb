class FavoritesController < ApplicationController

  def create
    if Favorite.where(comic_id: params[:comic_id], user_id: current_user.id).empty?
      Favorite.create(comic_id: params[:comic_id], user_id: current_user.id)
    end
    @comic = Comic.find(params[:comic_id])
  end

  def destroy
    dislike = Favorite.where(user_id: current_user.id, comic_id: params[:id])
    Favorite.destroy(dislike)
    @comic = Comic.find(params[:id])
  end
end
