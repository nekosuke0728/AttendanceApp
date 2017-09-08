require 'rails_helper'

RSpec.describe "Attendance#create", type: :model do
  let!(:user) { create(:user) }

  # 正常系 ====================================================

  it "データの保存に成功する" do
    expect(build(:attendance)).to be_valid
  end

end


# ========================================================================================================

RSpec.describe 'Attendance#update', type: :model do
  let!(:user) { create(:user) }

  # 正常系 ====================================================

  context "退勤時刻が打刻されている場合" do
    let(:attendance) { create(:attendance) }
    it "承認することができる" do
      attendance.update(end_at: 'Time.zone.local(2016, 8, 1, 17, 00, 00)')
    end
  end

  # 異常系 ====================================================

  context "退勤時刻が打刻されていない場合"  do
    let!(:attendance) { create(:attendance) }

    it "更新することができない" do
      expect(attendance.update(end_at: nil)).to be false
    end

    it "承認することができない" do
      expect(attendance.update(approval: "approved")).to be false
    end
  end
end

# ========================================================================================================

RSpec.describe Attendance, type: :model do
  let!(:user) { create(:user) }
  let!(:user2) { create(:user, :user2) }
  let!(:user3) { create(:user, :user3) }
  let!(:attendance) { create(:attendance) }
  let!(:attendance_user2) { create(:attendance, id: 6, user_id: 2) }
  let!(:attendance_user3) { create(:attendance, id: 7, user_id: 3) }
  # let!(:attendance_user2) { create(:attendance,:attendance_user2) }
  # let!(:attendance_user3) { create(:attendance,:attendance_user3) }
  let!(:attendance_approved) { create(:attendance, :attendance_approved) }
  let!(:attendance_unapproved) { create(:attendance, :attendance_unapproved) }
  let!(:attendance_embossed_finish) { create(:attendance, :attendance_embossed_finish) }
  let!(:attendance_embossed_unfinish) { create(:attendance, :attendance_embossed_unfinish) }
  let!(:attendance_date1) { create(:attendance, id: 8, start_at: Time.zone.local(2016, 8, 1, 9, 00, 00).to_s, end_at: Time.zone.local(2016, 8, 1, 17, 00, 00).to_s) }
  let!(:attendance_date2) { create(:attendance, id: 9, start_at: Time.zone.local(2016, 8, 2, 9, 00, 00).to_s, end_at: Time.zone.local(2016, 8, 2, 17, 00, 00).to_s) }
  let!(:attendance_date3) { create(:attendance, id: 10, start_at: Time.zone.local(2016, 8, 3, 9, 00, 00).to_s, end_at: Time.zone.local(2016, 8, 3, 17, 00, 00).to_s) }
  let!(:attendance_date4) { create(:attendance, id: 11, start_at: Time.zone.local(2016, 8, 4, 9, 00, 00).to_s, end_at: Time.zone.local(2016, 8, 4, 17, 00, 00).to_s) }
  let!(:attendance_date5) { create(:attendance, id: 12, start_at: Time.zone.local(2016, 8, 5, 9, 00, 00).to_s, end_at: Time.zone.local(2016, 8, 5, 17, 00, 00).to_s) }

  describe 'scopeの検索条件が' do

    context "ユーザー名：user1の場合" do
      it "user1の情報を取得できる" do
        expect(Attendance.get_by_user(1).pluck(:id)).to include attendance.id
      end
      it "user1以外の情報を取得できない" do
        expect(Attendance.get_by_user(1).pluck(:id)).not_to include attendance_user2.id
        expect(Attendance.get_by_user(1).pluck(:id)).not_to include attendance_user3.id
      end
    end

    context "承認状況：承認済の場合" do
      it "承認済の勤怠情報を取得できる" do
        # expect(Attendance.is_approved('approved')) == [attendance_approved]
        expect(Attendance.is_approved('approved').pluck(:id)).to include attendance_approved.id
        # expect(Attendance.is_approved('approved').first.id).to eq 4
      end
      it "未承認の勤怠情報を取得できない" do
        expect(Attendance.is_approved('approved').pluck(:id)).not_to include attendance_unapproved.id
      end
    end

    context "承認状況：未承認の場合" do
      it "未承認の勤怠情報を取得できる" do
        # expect(Attendance.is_approved('unapproved')) == [attendance_unapproved]
        expect(Attendance.is_approved('unapproved').pluck(:id)).to include attendance_unapproved.id
      end
      it "承認済の勤怠情報を取得できない" do
        expect(Attendance.is_approved('unapproved').pluck(:id)).not_to include attendance_approved.id
      end
    end

    context "打刻状況：打刻済の場合" do
      it "打刻済の勤怠情報を取得できる" do
        # expect(Attendance.has_embossed('embossed_finish')) == [attendance_embossed_finish]
        expect(Attendance.has_embossed(true).pluck(:id)).to include attendance_embossed_finish.id
      end
      it "未打刻の勤怠情報を取得できない" do
        # expect(Attendance.has_embossed('embossed_finish')) != [attendance_embossed_unfinish]
        expect(Attendance.has_embossed(true).pluck(:id)).not_to include attendance_embossed_unfinish.id
      end
    end

    context "打刻状況：未打刻の場合" do
      it "未打刻の勤怠情報を取得できる" do
        # expect(Attendance.has_embossed('embossed_unfinish')) == [attendance_embossed_unfinish]
        expect(Attendance.has_embossed(false).pluck(:id)).to include attendance_embossed_unfinish.id
      end
      it "打刻済の勤怠情報を取得できない" do
        expect(Attendance.has_embossed(false).pluck(:id)).not_to include attendance_embossed_finish.id
      end
    end

    context "日付範囲：打刻開始時刻の下限を2016/10/3に設定" do
      it "打刻開始時間が2016/10/3以降を取得できる" do
        expect(Attendance.starts_after(Time.zone.local(2016, 10, 3, 0, 00, 00).to_s).pluck(:id)).to include attendance_date3.id
        expect(Attendance.starts_after(Time.zone.local(2016, 10, 3, 0, 00, 00).to_s).pluck(:id)).to include attendance_date4.id
        expect(Attendance.starts_after(Time.zone.local(2016, 10, 3, 0, 00, 00).to_s).pluck(:id)).to include attendance_date5.id
      end
      it "打刻開始時間が2016/10/2以前を取得できない" do
        expect(Attendance.starts_after(Time.zone.local(2016, 10, 3, 0, 00, 00).to_s).pluck(:id)).not_to include attendance_date1.id
        expect(Attendance.starts_after(Time.zone.local(2016, 10, 3, 0, 00, 00).to_s).pluck(:id)).not_to include attendance_date2.id
      end
    end

    # context "日付範囲：打刻終了時刻の上限を2016/10/3に設定" do
    #   it "打刻終了時間が2016/10/3以前を取得できる" do
    #     expect(Attendance.ends_before('2016, 10, 3'.to_s).pluck(:id)).to include attendance_date1.id
    #     expect(Attendance.ends_before('2016, 10, 3'.to_s).pluck(:id)).to include attendance_date2.id
    #     expect(Attendance.ends_before('2016, 10, 3'.to_s).pluck(:id)).to include attendance_date3.id
    #   end
    #   it "打刻終了時間が2016/10/4以降を取得できない" do
    #     expect(Attendance.ends_before('2016, 10, 3'.to_s).pluck(:id)).not_to include attendance_date4.id
    #     expect(Attendance.ends_before('2016, 10, 3'.to_s).pluck(:id)).not_to include attendance_date5.id
    #   end
    # end

    # context "日付範囲：打刻開始時刻の下限を2016/10/3・打刻終了時刻の上限を2016/10/4に設定" do
    #   it "打刻終了時間が2016/10/3-4を取得できる" do
    #     expect(Attendance.date_select(start_at: '2016, 10, 3', end_at: '2016, 10, 4').pluck(:id)).to include attendance_date3.id
    #     expect(Attendance.date_select(start_at: '2016, 10, 3', end_at: '2016, 10, 4').pluck(:id)).to include attendance_date4.id
    #   end
    #   it "打刻終了時間が2016/10/1,2,5を取得できない" do
    #     expect(Attendance.date_select(start_at: '2016, 10, 3', end_at: '2016, 10, 4').pluck(:id)).not_to include attendance_date1.id
    #     expect(Attendance.date_select(start_at: '2016, 10, 3', end_at: '2016, 10, 4').pluck(:id)).not_to include attendance_date2.id
    #     expect(Attendance.date_select(start_at: '2016, 10, 3', end_at: '2016, 10, 4').pluck(:id)).not_to include attendance_date5.id
    #   end
    # end

  end
end
