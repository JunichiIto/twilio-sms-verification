require 'spec_helper'

describe PresentEntry do
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
  end
end
