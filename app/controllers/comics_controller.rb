class ComicsController < ApplicationController
  def index
    # ログインしていたらお気に入り情報を取得
    if user_signed_in?
      @favorites = User.find(current_user.id).favorite_comics
    end
    # 更新曜日ごとに最終更新+連載開始時で並び替え
    @comics_sun = Comic.where(weekday: 0).order(updated: :desc,created_at: :asc)
    @comics_mon = Comic.where(weekday: 1).order(updated: :desc,created_at: :asc)
    @comics_tue = Comic.where(weekday: 2).order(updated: :desc,created_at: :asc)
    @comics_wed = Comic.where(weekday: 3).order(updated: :desc,created_at: :asc)
    @comics_thu = Comic.where(weekday: 4).order(updated: :desc,created_at: :asc)
    @comics_fri = Comic.where(weekday: 5).order(updated: :desc,created_at: :asc)
    @comics_sat = Comic.where(weekday: 6).order(updated: :desc,created_at: :asc)
  end

  def show
  end
end
