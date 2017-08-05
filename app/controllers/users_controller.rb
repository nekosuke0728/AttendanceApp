class UsersController < ApplicationController
  before_action :authenticate_user!

  def top
    @attendance = current_user.attendances.last
  end

end
