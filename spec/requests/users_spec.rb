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
      it "sign_inにリダイレクトされているか" do
        get edit_user_path(user)
        expect(response).to redirect_to("/users")
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
      it "データベースに保存できたか"
      it "root_pathにリダイレクトされているか"
    end

    context "未ログイン時かつ保存失敗" do
      before do
        sign_in user
      end
      it "データベースに保存が行われなかったか"
      it "sign_upにリダイレクトされているか"
    end

    context "ログイン時" do
      before do
        sign_in user
      end
      it "リクエストに失敗しているか"
      it "rootにリダイレクトされているか"
    end
  end

  describe "PATCH/PUT #update" do
    let(:user) { create(:user) }
    context "未ログイン時" do
      it "リクエストに失敗しているか" 
      it "sign_inにリダイレクトされているか"
    end

    context "ログイン時かつ保存成功" do
      before do
        sign_in user
      end
      it "データベースに保存できたか"
      it "root_pathにリダイレクトされているか"
    end

    context "ログイン時かつ保存失敗" do
      before do
        sign_in user
      end
      it "データベースに保存が行われなかったか"
      it "editにリダイレクトされているか"
    end
  end
end
