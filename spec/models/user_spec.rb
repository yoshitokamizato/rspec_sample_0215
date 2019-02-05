require 'rails_helper'

RSpec.describe User, type: :model do
  describe "四則演算" do
    describe "足し算" do
      it '1 + 1 = 2' do
        expect(1+1).to eq 2
      end
    end
    describe "引き算" do
      it '1 - 9 = 10' do
        expect(1-9).to eq -8
      end
    end
  end
end
