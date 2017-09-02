require 'rails_helper'

RSpec.describe AdminsController, type: :controller do

  describe "GET #top" do

    context 'ログインしている場合' do
      before do
      @admin = create(:admin)
      sign_in @admin
      get :top
      end
      it 'レスポンスステータス200を返す' do
        expect(response.status).to eq(200)
      end
    end

    context 'ログインしていない場合' do
      let!(:admin) { create(:admin) }
      before { get :top }
      it 'レスポンスステータス302を返す' do
        expect(response.status).to eq(302)
      end
    end

  end

end