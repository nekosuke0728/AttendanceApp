require 'rails_helper'

RSpec.describe "user#create", type: :model do

  # 正常系 ====================================================

  it "データの保存に成功する" do
    expect(build(:user)).to be_valid
  end

  # 異常系 ====================================================
  
  context "メールアドレスが空欄の場合は" do
    it "作成できない" do
      expect(build(:user,:email_is_nil)).to be_invalid
    end
  end

  context "パスワードが空欄の場合は" do
    it "作成できない" do
      expect(build(:user,:password_is_nil)).to be_invalid
    end
  end

  context "名前が空欄の場合は" do
    it "作成できない" do
      expect(build(:user,:name_is_nil)).to be_invalid
    end
  end

  context "誕生日が空欄の場合は" do
    it "作成できない" do
      expect(build(:user,:birthday_is_nil)).to be_invalid
    end
  end

  context "性別が空欄の場合は" do
    it "作成できない" do
      expect(build(:user,:gender_is_nil)).to be_invalid
    end
  end

  context "契約種別が空欄の場合は" do
    it "作成できない" do  
      expect(build(:user,:employment_status_is_nil)).to be_invalid
    end
  end

  context "住所が空欄の場合は" do
    it "作成できない" do   
      expect(build(:user,:address_is_nil)).to be_invalid
    end
  end

  context "電話番号が空欄の場合は" do
    it "作成できない" do  
      expect(build(:user,:phone_is_nil)).to be_invalid
    end
  end

end


