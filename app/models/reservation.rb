class Reservation < ApplicationRecord
  require "price_decorator.rb"
  belongs_to :profile
  belongs_to :shop
  
  validates_presence_of :dropoffdate, :pickupdate, :numluggage
  validate :wrong_pickupdate
  
  
  def wrong_pickupdate
    if pickupdate < dropoffdate
      errors.add(:pickupdate, "can not be in the past")
    end
  end
 
end
