class Attendance < ApplicationRecord
  belongs_to :user

  validates :start_at, presence: true
  validates :end_at, presence: true, on: :manual

  enum approval: { approved: true, unapproved: false }

=begin

  scope :get_by_user_id, ->(user_id) { where(user_id: user_id) if user_id.present? }

  scope :select_day, ->(start_at, end_at) {
  start_at_datetime =  Time.mktime start_at["start_at(1i)"].to_i, start_at["start_at(2i)"].to_i, start_at["start_at(3i)"].to_i, 00, 00, 00 if start_at
  end_at_datetime   =  Time.mktime end_at["end_at(1i)"].to_i, end_at["end_at(2i)"].to_i, end_at["end_at(3i)"].to_i, 23, 59, 59 if end_at
  if start_at_datetime.present? && end_at_datetime.present?
    where('start_at > ?', start_at_datetime).where('end_at < ?', end_at_datetime)
  elsif end_at_datetime.present?
    where('end_at < ?', end_at_datetime)
  elsif start_at_datetime.present?
    where('start_at > ?', start_at_datetime)
  end
  }

  scope :get_by_approval, ->(approval) { where(approval: approval) if approval.present? }

=end

=begin
  scope :user_id_has, ->(user_id) { where(user_id: user_id) if user_id.present? }
=end

  scope :get_by_user, ->(u_id) { where(user_id: u_id) if u_id.present? }

  scope :date_select, ->(start_at, end_at) {

    if start_at.present? && end_at.present?
      where('start_at > ?', start_at).where('end_at < ?', end_at)
    elsif end_at.present?
      where('end_at < ?', end_at)
    elsif start_at.present?
      where('start_at > ?', start_at)
    end

  }

scope :embossed_unfinish, -> {
  where(end_at: nil) 
}

scope :embossed_finish, -> {
  where.not(end_at: nil)
}

end
