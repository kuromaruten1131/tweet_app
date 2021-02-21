require 'rails_helper'

RSpec.describe Tweet, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @another_user = FactoryBot.create(:another_user)
  end
  it "1文字以上140字以内でツイートできる" do
    user = @user
    tweet = user.tweets.build(
      content: "テスト",
      user_id: 1
      )
    expect(tweet).to be_valid
  end
  it "空のツイートはできない" do
    user = @user
    tweet = user.tweets.build(
      content: "",
      user_id: 1
      )
      tweet.valid?
      expect(tweet.errors[:content]).to include("is too short (minimum is 1 character)")
  end
  it "140字以上のツイートはできない" do
    user = @user
    tweet = user.tweets.build(
      content: "1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111",
      user_id: 1
      )
      tweet.valid?
      expect(tweet.errors[:content]).to include("is too long (maximum is 140 characters)")
  end
end
