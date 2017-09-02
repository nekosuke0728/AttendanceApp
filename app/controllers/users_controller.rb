class UsersController < ApplicationController
  before_action :authenticate_admin!, only: [:index]
  before_action :authenticate_user!, only: [:top]

  def account_index
    @users = User.all
  end

  def top
    @attendance = Attendance.where(user_id: current_user.id).order(start_at: :desc).first
  end

end
