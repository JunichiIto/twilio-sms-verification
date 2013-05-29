# coding: utf-8
class PresentEntry < ActiveRecord::Base
  VERIFICATION_CODE_LENGTH = 6
  
  attr_accessible :address, :email, :mobile_phone_number, :name
  validates_presence_of :address, :email, :mobile_phone_number, :name

  after_create :issue_verification_code
  after_create :send_verification_code

  private

  def issue_verification_code
    self.verification_code = VERIFICATION_CODE_LENGTH.times.map{ Random.rand(9) + 1 }.join
    self.save!
  end

  def send_verification_code
    twilio_client.account.sms.messages.create(
      from: ENV["TWILIO_NUMBER"],
      to: self.mobile_phone_number,
      body: "この認証コードを入力してください。\n#{verification_code}"
    )
  end

  def twilio_client
    @twilio_client ||= Twilio::REST::Client.new ENV["TWILIO_SID"], ENV["TWILIO_TOKEN"]
  end
end
