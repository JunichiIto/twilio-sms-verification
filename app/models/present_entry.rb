class PresentEntry < ActiveRecord::Base
  VERIFICATION_CODE_LENGTH = 6
  
  attr_accessible :address, :email, :mobile_phone_number, :name
  validates_presence_of :address, :email, :mobile_phone_number, :name

  after_create :issue_verification_code

  private

  def issue_verification_code
    self.verification_code = VERIFICATION_CODE_LENGTH.times.map{ Random.rand(9) + 1 }.join
    self.save!
  end
end
