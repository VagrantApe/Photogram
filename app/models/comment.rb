class Comment < ActiveRecord::Base
  #paginates_per 4
  belongs_to :user
  belongs_to :post
end
