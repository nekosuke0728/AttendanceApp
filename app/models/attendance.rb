class Attendance < ApplicationRecord
  belongs_to :user

  validates :start_at, presence: true
  validates :end_at, presence: true, on: :manual

  validates_datetime :end_at, :after => :start_at, on: :update

  enum approval: { approved: true, unapproved: false }
  enum request: { applied: true, unapplied: false }
  enum edit: { edited: true, unedited: false }


  scope :get_by_user, ->(user_id) { where(user_id: user_id) if user_id.present? }
  scope :has_embossed, ->(status) {
    if status == true
      where.not(end_at: nil)
    elsif status == false
      where(end_at: nil)
    end
  }
  scope :is_approved, ->(status) { where(approval: status) unless status.nil? }
  scope :starts_after, ->(start_at) { where('start_at > ?', start_at) if start_at.present? }
  scope :ends_before, ->(end_at) { where('end_at < ?', end_at) if end_at.present? }

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
