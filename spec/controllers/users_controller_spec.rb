require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "GET #top" do

    context 'ログインしている場合' do
      before do
        @user = create(:user)
        sign_in @user
        get :top, params: { id: 1 }
      end
      it 'レスポンスステータス200を返す' do
        expect(response.status).to eq(200)
      end
    end

    context 'ログインしていない場合' do
      before { get :top, params: { id: 1 } }
      it 'レスポンスステータス302を返す' do
        expect(response.status).to eq(302)
      end
    end

  end

end