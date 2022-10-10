class Business < ActiveRecord::Base
  has_many :reviews
  has_many :users, through: :reviews

  paginates_per 10
end
