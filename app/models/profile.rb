class Profile < ApplicationRecord
  belongs_to :user
  has_many :reservations
  has_one_attached :picture
  
  validates_presence_of :name, :telephone
  
  validates :telephone,:numericality => true,
                       :length => { :minimum => 9, :maximum => 12 }
                        
  validates_format_of :name, :with => /\A[^0-9`!@#\$%\^&*+_=]+\z/
  
  validates :name,:length => { :minimum => 6, :maximum => 20 }



                        
                        
end
