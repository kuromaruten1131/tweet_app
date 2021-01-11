require 'rails_helper'

RSpec.describe User, type: :model do
  it "passwordは6文字以上かつEmailが正しく入力されており、nicknameの入力がある" do
    expect(FactoryBot.build(:user)).to be_valid
  end
  it "passwordが5文字で登録できない" do
    user = FactoryBot.build(:user, password: "12345", password_confirmation: "12345")
    user.valid?
    expect(user.errors[:password]).to include("is too short (minimum is 6 characters)")
  end
  it "passwordとpassword_confirmationが異なっていると登録できない" do
    user = FactoryBot.build(:user, password: "111111", password_confirmation: "211111")
    user.valid?
    expect(user.errors[:password_confirmation]).to include("doesn't match Password")
  end
  it "Emailに@がないと登録できない" do
    user = FactoryBot.build(:user, email: "aaa")
    user.valid?
    expect(user.errors[:email]).to include("is invalid")
  end
  it "Emailに@が2つあると登録できない" do
    user = FactoryBot.build(:user, email: "a@@a")
    user.valid?
    expect(user.errors[:email]).to include("is invalid")
  end
  it "Emailの途中に空白があると登録できない" do
    user = FactoryBot.build(:user, email: "a @a")
    user.valid?
    expect(user.errors[:email]).to include("is invalid")
  end
  it "Emailがユニークであれば登録できる" do
    FactoryBot.create(:user)
    expect(FactoryBot.build(:user, email: "b@b")).to be_valid
  end
  it "Emailがユニークでなければ登録できない" do
    FactoryBot.create(:user)
    user = FactoryBot.build(:user)
    user.valid?
    expect(user.errors[:email]).to include("has already been taken")
  end
  it "nicknameがないと登録できない" do
    user = FactoryBot.build(:user, nickname: "")
    user.valid?
    expect(user.errors[:nickname]).to include("is too short (minimum is 1 character)")
  end
end
