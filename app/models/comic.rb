class Comic < ActiveRecord::Base
  belongs_to :site
  has_many :favorites
  has_many :comments
  has_many :favorite_users, through: :favorites, source: :user
end
