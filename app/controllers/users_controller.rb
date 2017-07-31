class UsersController < ApplicationController
  before_action :authenticate_user!
  def top    
  end
end