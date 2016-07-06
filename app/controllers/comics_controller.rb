class ComicsController < ApplicationController
  def index
    @comics = Comic.order("id asc")
  end

  def show
  end
end
