require 'spec_helper'

describe PresentEntry do
  describe '#new' do
    it 'is not verified by default' do
      expect(PresentEntry.new).not_to be_verified
    end
  end
end
