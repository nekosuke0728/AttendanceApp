class Attendance < ApplicationRecord
  belongs_to :user

  # validates_datetime :start_at
  # validates_datetime :end_at
  # validates_datetime :end_at, after: :start_at

  validates :start_at, presence: true, on: :create
  validates :end_at, presence: true, on: :create

  

end
