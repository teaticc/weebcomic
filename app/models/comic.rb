class Comic < ActiveRecord::Base
  belongs_to :site
  has_many :favorites
  has_many :comments
end
