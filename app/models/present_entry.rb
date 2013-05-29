class PresentEntry < ActiveRecord::Base
  attr_accessible :address, :email, :mobile_phone_number, :name
  validates_presence_of :address, :email, :mobile_phone_number, :name
end
