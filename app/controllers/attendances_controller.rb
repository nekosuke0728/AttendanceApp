class AttendancesController < ApplicationController
  before_action :authenticate_admin!, only: [:index, :destroy, :approval, :approval_status_change]
  before_action :authenticate_user!, only: [:create, :new, :user_edit, :start_attendance, :end_attendance, :request_status_change, :user_index]
  before_action :authenticate_all, only: [:edit, :update, :show]

  include AjaxHelper 

  # user 勤怠一覧 v
  def user_index
    @attendances = current_user.attendances.order(start_at: :desc)

    if @attendances != nil
      if current_user.attendances.present?
        @start_at = current_user.attendances.order(:start_at).first.start_at
      end
      @end_at = Date.today
    end

    if params[:start_at].present? && params[:start_at]['year'].present? && params[:end_at].present? && params[:end_at]['year'].present?
      @start_at =  Time.mktime params[:start_at]["year"].to_i, params[:start_at]["month"].to_i, params[:start_at]["day"].to_i, 00, 00, 00
      @end_at   =  Time.mktime params[:end_at]["year"].to_i, params[:end_at]["month"].to_i, params[:end_at]["day"].to_i, 23, 59, 59
      if @start_at != nil
        @attendances = @attendances.date_select(@start_at, @end_at)
      end
    end
  end

  # admin ユーザー勤怠一覧
  def index
    @attendances = Attendance.page(params[:page]).per(100).includes(:user).order(start_at: :desc)

    if params[:user_id].present?
      @user_id = params[:user_id]
      @attendances = @attendances.get_by_user(@user_id)
    end

    if @attendances != nil
      @start_at = Attendance.order(:start_at).first.start_at
      @end_at = [ Attendance.order(:end_at).last.end_at, Time.now ].max
    end

    if params[:embossed] == 'embossed_unfinish'
      @embossed = 'embossed_unfinish'
      @attendances = @attendances.embossed_unfinish
    elsif  params[:embossed] == 'embossed_finish'
      @embossed = 'embossed_finish'
      @attendances = @attendances.embossed_finish
    else
      @embossed = ''
      @attendances = @attendances
    end

    if params[:start_at].present? && params[:start_at]['year'].present? && params[:end_at].present? && params[:end_at]['year'].present?
      @start_at =  Time.mktime params[:start_at]["year"].to_i, params[:start_at]["month"].to_i, params[:start_at]["day"].to_i, 00, 00, 00
      @end_at   =  Time.mktime params[:end_at]["year"].to_i, params[:end_at]["month"].to_i, params[:end_at]["day"].to_i, 23, 59, 59
      if @embossed == 'embossed_finish'
        @attendances = @attendances.date_select(@start_at, @end_at)
      elsif @embossed == 'embossed_unifinish'
        @attendances = @attendances.date_select(@start_at, nil)
      elsif @embossed == ''
        @attendances = @attendances.date_select(@start_at, @end_at)
      end
    end

    if params[:approval] == 'approved'
      @approval = 'approved'
      @attendances = @attendances.approved
    elsif params[:approval] == 'unapproved'
      @approval = 'unapproved'
      @attendances = @attendances.unapproved
    else 
      @approval = ''
      @attendances = @attendances
    end

  end

  # user ユーザー勤怠新規登録
  def create
    @user = current_user.id
    @attendance = Attendance.new(attendance_params)
    if @attendance.save(context: :manual)
      redirect_to users_path(current_user.id), notice: '申請が完了しました'
    end
  end

  # user 勤怠新規登録（直接入力） v
  def new
    @user = current_user.id
    @attendance = Attendance.new
  end

  # admin & user 勤怠情報修正 v
  def edit
    @attendance = Attendance.find_by(id: params[:id])
  end

  # admin & user 勤怠情報修正
  def update
    @attendance = Attendance.find_by(id: params[:id])
    if @attendance.update(attendance_params)
      redirect_to attendance_path(@attendance.id)
    else
      @error = "終了時間が開始時間よりも早い時間を選択しています"
      render 'attendances/edit'
    end
  end

  # admin 勤怠個別表示 v
  def show
    @attendance = Attendance.find(params[:id])
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
    if attendance.approved?
      attendance.unapproved!
    else
      attendance.approved!
    end
    respond_to do |format|
      format.js { render ajax_redirect_to(attendances_path) }
    end
  end

  private

  def attendance_params
    params.require(:attendance).permit(:start_at, :end_at, :user_id, :request, :approval, :edit)
  end

  def authenticate_all
    user_signed_in? || admin_signed_in?
  end

end

