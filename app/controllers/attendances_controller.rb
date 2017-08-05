class AttendancesController < ApplicationController
  before_action :authenticate_admin!, only: [:index, :destroy, :approval]
  before_action :authenticate_user!, only: [:create, :new, :edit, :show, :update, :start, :end, :request_status_change]

  # admin 確認一覧用 v
  def index
    
  end

  # user 勤怠新規登録
  def create
    # @user = current_user.id
    # @attendance = Attendance.new(attendance_params)
    # @attendance.save
    # redirect_to users_path(current_user.id), notice: '申請が完了しました'
    @user = current_user.id
    @attendance = Attendance.new(attendance_params)
    if @attendance.save
      redirect_to users_path(current_user.id), notice: '申請が完了しました'
    else
      flash.now[:alert] = "未入力の項目があります"
      render :action => :new
    end
  end

  # user 勤怠新規登録（直接入力） v
  def new
    @user = current_user.id
    @attendance = Attendance.new
  end

  # user 勤怠情報修正 v
  def edit
    
  end

  # user 勤怠個別表示 v
  def show
    
  end

  # user 勤怠情報修正
  def update
    
  end

  # admin 勤怠情報削除
  def destroy
    
  end

  # admin 勤怠承認
  def approval
    
  end

  def start
    @attendance = Attendance.new
    @attendance.user_id = current_user.id
    @attendance.start_at = Time.zone.now
    @attendance.save
    redirect_to users_path(current_user.id) and return
  end

  def end
    @attendance = current_user.attendances.last
    if @attendance.start_at.present?
      now = Time.zone.now
      @attendance.update(end_at: now)
    end
    redirect_to users_path(current_user.id) and return
  end

  def request_status_change
    @attendance = current_user.attendances.last
    if @attendance.request == false
      @attendance.update(request: true)
    end
    redirect_to users_path(current_user.id) and return
  end

  private

  def attendance_params
    params.require(:attendance).permit(:start_at, :end_at, :user_id, :request, :approval, :edit)
  end

end

