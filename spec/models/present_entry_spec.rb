require 'spec_helper'

describe PresentEntry do
  describe '#new' do
    it 'is not verified by default' do
      expect(build :present_entry).not_to be_verified
    end
  end

  describe '#save' do
    let(:messages) { stub 'messages' }
    let(:present_entry) { build :present_entry }

    before do
      messages.stub(:create)
      Twilio::REST::Client.stub_chain(:new, :account, :sms, :messages).and_return(messages)
    end

    it 'has random verification code after create' do
      expect{present_entry.save}.to change{present_entry.verification_code}.from(nil)
    end

    it 'sends verification code after create' do
      messages.should_receive(:create)
      present_entry.save
    end
  end
end
