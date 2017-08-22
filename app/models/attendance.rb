class Attendance < ApplicationRecord
  belongs_to :user

  validates :start_at, presence: true
  validates :end_at, presence: true, on: :manual

  validates_datetime :end_at, :after => :start_at, on: :update

  enum approval: { approved: true, unapproved: false }

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

  scope :embossed_unfinish, -> { where(end_at: nil) }

  scope :embossed_finish, -> { where.not(end_at: nil) }

end
