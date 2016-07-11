class ComicsController < ApplicationController
  def index
    @comics = Comic.order(updated: :desc,created_at: :asc)
    @weekdays = ["sun", "mon", "tue", "wed", "thu", "fri", "sat"]
  end

  def show
  end

end
