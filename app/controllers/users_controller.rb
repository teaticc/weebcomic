class UsersController < ApplicationController
  def show
    @fav_comics = User.find(id = current_user.id).favorite_comics.order(updated: :desc)
  end
end
