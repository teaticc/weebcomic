class FavoritesController < ApplicationController

  def create
    if Favorite.where(comic_id: params[:comic_id], user_id: current_user.id)[0] == nil
      Favorite.create(user_id: current_user.id, comic_id: params[:comic_id])
    end
    # redirect_to :root
  end

  def destroy
    dislike = Favorite.where(user_id: current_user.id, comic_id: params[:id])
    Favorite.destroy(dislike)
    # redirect_to :root
  end
end
