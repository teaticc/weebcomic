class Comment < ActiveRecord::Base
  belongs_to :comic
  belongs_to :user
end
