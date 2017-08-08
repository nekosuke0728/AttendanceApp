class AttendancesController < ApplicationController
  before_action :authenticate_admin!, only: [:index, :destroy, :approval, :approval_status_change]
  before_action :authenticate_user!, only: [:create, :new, :edit, :show, :update, :start, :end, :request_status_change]

  include AjaxHelper 

  # admin 確認一覧用 v
  def index
    @attendances = Attendance
      .get_by_user_id params[:user_id]
      .select_day params[:start_at] params[:end_at]
      .page(params[:page]).per(100).includes(:user)


      # params[:attendance][:user_id]
    # title = params[:title].presence
    # min_price = params[:min_price].presence
    # max_price = params[:max_price].presence


    # @items = Item.title_has(title)
    #              .higher_than(min_price)
    #              .lower_than(max_price)

    # user_name = params[:user_name].presence

    # @attendances = Attendance.page(params[:page]).per(100).includes(:user)
    #                 .user_name_select(user_name)

    # .user_name_select(user_id)

 #    if params[:user_id]
	# @attendance = Attendance.user_name_select(params[:page]).includes(:user)
	# return @attendance.delete("^0-9")
 #    end

  end

  # user 勤怠新規登録
  def create
    # @user = current_user.id
    # @attendance = Attendance.new(attendance_params)
    # @attendance.save
    # redirect_to users_path(current_user.id), notice: '申請が完了しました'
    @user = current_user.id
    @attendance = Attendance.new(attendance_params)
    if @attendance.save(context: :manual)
      redirect_to users_path(current_user.id), notice: '申請が完了しました'
    # else
    #   flash.now[:alert] = "未入力の項目があります"
    #   render :action => :new
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

  def start_attendance
    @attendance = Attendance.new
    @attendance.user_id = current_user.id
    @attendance.start_at = Time.zone.now
    @attendance.save
    redirect_to users_path(current_user.id) and return
  end

  def end_attendance
    @attendance = current_user.latest_attendance
    if @attendance.start_at.present?
      now = Time.zone.now
      @attendance.update(end_at: now)
    end
    redirect_to users_path(current_user.id) and return
  end

  def request_status_change
    @attendance = current_user.latest_attendance
    if @attendance.request == false
      @attendance.update(request: true)
    end
    redirect_to users_path(current_user.id) and return
  end

  def approval_status_change
    attendance = Attendance.find(params[:id])
    if attendance.approval == false
      attendance.update(approval: true)
    else
      attendance.update(approval: false)
    end

    respond_to do |format|
      format.js { render ajax_redirect_to(attendances_path) }
    end
  end


  private

  def attendance_params
    params.require(:attendance).permit(:start_at, :end_at, :user_id, :request, :approval, :edit)
  end

end

