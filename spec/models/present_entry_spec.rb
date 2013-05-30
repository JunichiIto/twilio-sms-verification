# coding: utf-8
require 'spec_helper'

describe PresentEntry do
  let(:messages) { stub 'messages' }
  before do
    messages.stub(:create)
    Twilio::REST::Client.stub_chain(:new, :account, :sms, :messages).and_return(messages)
  end

  describe '#new' do
    it 'is not verified by default' do
      expect(build :present_entry).not_to be_verified
    end
  end

  describe '#save' do
    let(:present_entry) { build :present_entry }

    it 'has random verification code after create' do
      expect{present_entry.save}.to change{present_entry.verification_code}.from(nil)
    end

    it 'sends verification code after create' do
      messages.should_receive(:create)
      present_entry.save
    end

    it 'formats mobile phone number' do
      messages.should_receive(:create).with(hash_including(to: "+818000000000"))
      present_entry.save
    end
  end

  describe 'validation' do
    describe 'for mobile_phone_number' do
      let(:present_entry) { build :present_entry, mobile_phone_number: mobile_phone_number }
      context 'when contain hypens' do
        let(:mobile_phone_number) { '080-1234-1234' }
        specify do
          expect{present_entry.valid?}.not_to change{present_entry.errors[:mobile_phone_number]}.from([])
        end
      end
      context 'when contain no hypens' do
        let(:mobile_phone_number) { '08012341234' }
        specify do
          expect{present_entry.valid?}.not_to change{present_entry.errors[:mobile_phone_number]}.from([])
        end
      end
      context 'when contain non number' do
        let(:mobile_phone_number) { '080-1234-123A' }
        specify do
          expect{present_entry.valid?}.to change{present_entry.errors[:mobile_phone_number]}.from([])
        end
      end
      context 'when too short' do
        let(:mobile_phone_number) { '0801234123' }
        specify do
          expect{present_entry.valid?}.to change{present_entry.errors[:mobile_phone_number]}.from([])
        end
      end
      context 'when too long' do
        let(:mobile_phone_number) { '080-1234-12345' }
        specify do
          expect{present_entry.valid?}.to change{present_entry.errors[:mobile_phone_number]}.from([])
        end
      end
    end
  end

  describe '#verify_and_save' do
    let(:present_entry) { create :present_entry }
    let(:attributes) { { verification_code_confirmation: verification_code_confirmation } }
    context 'when valid' do
      let(:verification_code_confirmation) { present_entry.verification_code }
      it 'has been verified' do
        expect{present_entry.verify_and_save(attributes)}.to change{present_entry.verified}.from(false).to(true)
      end
      it 'clears verification code' do
        expect{present_entry.verify_and_save(attributes)}.to change{present_entry.verification_code}.to(nil)
      end
      it 'returns true' do
        expect(present_entry.verify_and_save(attributes)).to be_true
      end
    end
    context 'when invalid' do
      let(:verification_code_confirmation) { "123456" }
      it 'has not been verified' do
        expect{present_entry.verify_and_save(attributes)}.not_to change{present_entry.verified}.from(false)
      end
      it 'does not clear verification code' do
        expect{present_entry.verify_and_save(attributes)}.not_to change{present_entry.verification_code}
      end
      it 'returns false' do
        expect(present_entry.verify_and_save(attributes)).to be_false
      end
      it 'adds error on verification_code_confirmation' do
        expect{present_entry.verify_and_save(attributes)}.to change{present_entry.errors[:verification_code_confirmation]}.from([]).to(['は不正な値です。'])
      end
    end
  end
end
