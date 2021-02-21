require 'rails_helper'

RSpec.describe "UsersController", type: :request do
  describe "GET #index" do
    let(:user) { create(:user) }
    context "未ログイン時" do
      it "リクエストに失敗しているか" do
        get users_path
        expect(response).to have_http_status(302)
      end
      it "sign_inにリダイレクトされているか" do
        get users_path
        expect(response).to redirect_to("/users/sign_in")
      end
    end

    context "ログイン時" do
      before do
        sign_in user
      end
      it "リクエストが成功しているか" do
        get users_path
        expect(response).to have_http_status(200)
      end
      it "ユーザー名が表示されているか" do
        get users_path
        expect(response.body).to include("test_user")
      end
    end
  end


  describe "GET #show" do
    let(:user) { create(:user) }
    
    context "未ログイン時" do
      it "リクエストに失敗しているか" do
        get user_path(user)
        expect(response).to have_http_status(302)
      end
      it "sign_inにリダイレクトされているか" do
        get user_path(user)
        expect(response).to redirect_to("/users/sign_in")
      end
    end

    context "ログイン時" do
      before do
        sign_in user
      end
      it "リクエストが成功しているか" do
        get user_path(user)
        expect(response).to have_http_status(200)
      end
      it "ユーザー名が表示されているか" do
        get user_path(user)
        expect(response.body).to include("test_user")
      end
    end
  end


  describe "GET #edit" do
    let(:user) { create(:user) }
    let(:another_user) { create(:another_user) }
    context "未ログイン時" do
      it "リクエストに失敗しているか" do
        get edit_user_path(user)
        expect(response).to have_http_status(302)
      end
    end

    context "ログイン時" do
      before do
        sign_in user
      end
      it "リクエストが成功しているか" do
        get edit_user_path(user)
        expect(response).to have_http_status(200)
      end
      it "ユーザー名が表示されているか" do
        get edit_user_path(user)
        expect(response.body).to include("test_user")
      end
      it "別ユーザーのeditへのアクセス時、indexにリダイレクトされているか" do
        get edit_user_path(another_user)
        expect(response).to redirect_to("/users")
      end
    end
  end

  
  describe "POST #create" do
    let(:user) { create(:user) }
    context "未ログイン時かつ保存成功" do
      it "データベースに保存できたか" do
        expect do
          post user_registration_path, params: { user: FactoryBot.attributes_for(:user) }
        end.to change(User, :count).by(1)
      end
      it "root_pathにリダイレクトされているか" do
        post user_registration_path, params: { user: FactoryBot.attributes_for(:user) }
        expect(response).to redirect_to("/")
      end
    end

    context "未ログイン時かつ保存失敗" do
      before do
        sign_in user
      end
      it "データベースに保存が行われなかったか" do
        expect do
          post user_registration_path, params: { user: FactoryBot.attributes_for(:user, :invalid) }
        end.to_not change(User, :count)
      end
    end

    context "ログイン時" do
      before do
        sign_in user
      end
      it "リクエストに失敗しているか" do
        post user_registration_path, params: { user: FactoryBot.attributes_for(:user) }
        expect(response).to have_http_status(302)
      end
      it "rootにリダイレクトされているか" do
        post user_registration_path, params: { user: FactoryBot.attributes_for(:user, :invalid) }
        expect(response).to redirect_to("/")
      end
    end
  end


  describe "PATCH/PUT #update" do
    let(:user) { create(:user) }
    context "未ログイン時" do
      it "リクエストに失敗しているか" do
        put user_path(user), params: { user: FactoryBot.attributes_for(:user) }
        expect(response).to have_http_status(302)
      end
    end

    context "ログイン時かつ更新成功" do
      before do
        sign_in user
      end
      it "データベースが更新されたか" do
        expect do
          put user_path(user), params: { user: FactoryBot.attributes_for(:another_user) }
        end.to change { User.find(user.id).nickname }.from("test_user").to("test_another_user")
      end
      it "userにリダイレクトされているか" do
        put user_path(user), params: { user: FactoryBot.attributes_for(:another_user) }
        expect(response).to redirect_to User.last
      end
    end

    context "ログイン時かつ更新失敗" do
      before do
        sign_in user
      end
      it "データベースに保存が行われなかったか" do
        expect do
          put user_path(user), params: { user: FactoryBot.attributes_for(:user, :invalid) }
        end.to_not change(User.find(user.id), :nickname)
      end
    end
  end
end
