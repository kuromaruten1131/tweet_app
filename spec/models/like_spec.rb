require 'rails_helper'

RSpec.describe Like, type: :model do
  it "いいねができる" do
    expect(FactoryBot.build(:like)).to be_valid
  end
  it "同じツイートをいいねできない" do
  end
end
