class Attendance < ApplicationRecord
  belongs_to :user

  # validates_datetime :start_at
  # validates_datetime :end_at
  # validates_datetime :end_at, after: :start_at

  validates :start_at, presence: true
  validates :end_at, presence: true, on: :manual

  # scope :title_has, ->(word) { where(Item.arel_table[:title].matches("%#{word}%")) unless word.nil? }
  # scope :higher_than, ->(price) { where(Item.arel_table[:price].gteq(price)) unless price.nil? }
  # scope :lower_than, ->(price) { where(Item.arel_table[:price].lteq(price)) unless price.nil? }

  # scope :user_id_select, ->(user_id) { where(Attendance.arel_table[:user_id_select].matches("%#{user_id}%")) unless user_id.nil?}

 # scope :user_name_select, ->(user_id) {where(Attendance.arel_table[:user_id].matches(user_id)) unless user_id.nil? }

 #  scope :user_name_select, ->(user_id) {
	# where("user_id like?", "user_id")
	# return user_name_select.delete("^0-9")
 # }

 # scope :user_name_select, ->(word) { where(Attendance.arel_table[:user_name].matches("%#{word}%")) unless word.nil? }



scope :get_by_user_id, ->(user_id) { where(user_id: user_id) if params[:user_id].present? }
scope :select_day, ->(start_at, end_at) {
  where(user_id: user_id) if params[:user_id].present?
}


end
