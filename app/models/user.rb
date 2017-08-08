class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :attendances

  enum gender: { 
    male: 0, 
    female: 1, 
    lgbt: 2 
  }
  enum employment_status: { 
    regular_employee: 0, 
    contract_employee: 1, 
    part_time_job: 2,
    other: 3
  }

  validates :name, presence: true
  validates :birthday, presence: true
  validates :gender, presence: true
  validates :employment_status, presence: true
  validates :address, presence: true
  validates :phone, presence: true

  def can_start?
    # 未申請の勤怠があれば勤怠開始はできない
    return false if Attendance.where(user_id: self.id, request: false).count > 0
    # 未申請の勤怠がなく、今日の勤怠がなければ、勤怠は開始できる
    self.attendance_of_today.blank?
  end

  def can_end?
    attendance_of_today = self.attendance_of_today
    attendance_of_today.present? && attendance_of_today.end_at.blank?
  end

  def can_request?
    Attendance.where(user_id: self.id, request: false).count > 0
  end

  def attendance_of_today
    Attendance.where(
      user_id: self.id,
      start_at: DateTime.now().beginning_of_day .. DateTime.now().beginning_of_day + 1.day
    ).last
  end

  def latest_attendance
    Attendance.where(user_id: self.id).order(start_at: :desc).first
  end
  
end
