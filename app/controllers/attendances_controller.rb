class AttendancesController < ApplicationController
  before_action :authenticate_admin!, only: [:index, :destroy, :approval_status_change]
  before_action :authenticate_user!, only: [:new, :create, :start_attendance, :end_attendance, :user_index, :request_status_change]
  before_action :authenticate_all, only: [:edit, :update, :show]

  include AjaxHelper

  # 勤怠データ新規作成 ====================================================================================================================

  # user 手入力
  def new
    @user = current_user.id
    @attendance = Attendance.new
  end

  def create
    @user = current_user.id
    @attendance = Attendance.new(attendance_params)
    if @attendance.save(context: :manual)
       redirect_to users_path(current_user.id), notice: '申請が完了しました'
    else
       @error = "未入力の項目があります"
       render 'attendances/new'
    end
  end

  # user 開始ボタン
  def start_attendance
    @attendance = Attendance.new
    @attendance.user_id = current_user.id
    @attendance.start_at = Time.zone.now
    @attendance.save
    redirect_to users_path(current_user.id) and return
  end

  # user 終了ボタン
  def end_attendance
    @attendance = current_user.latest_attendance
    if @attendance.start_at.present?
      now = Time.zone.now
      @attendance.update(end_at: now)
    end
    redirect_to users_path(current_user.id) and return
  end

  # 勤怠データ修正 ====================================================================================================================

  # admin & user
  def edit
    @attendance = Attendance.find_by(id: params[:id])
  end

  def update
    @attendance = Attendance.find_by(id: params[:id])
    if @attendance.update(attendance_params)
      redirect_to attendance_path(@attendance.id)
    else
      @error = "終了時間が開始時間よりも早い時間を選択しています"
      render 'attendances/edit'
    end
  end

  # 勤怠一覧 ====================================================================================================================

  # user
  def user_index

    if params[:start_at].present? && params[:start_at]['year'].present? && params[:end_at].present? && params[:end_at]['year'].present?
      @start_at =  Time.mktime params[:start_at]["year"].to_i, params[:start_at]["month"].to_i, params[:start_at]["day"].to_i, 00, 00, 00
      @end_at   =  Time.mktime params[:end_at]["year"].to_i, params[:end_at]["month"].to_i, params[:end_at]["day"].to_i, 23, 59, 59
    end

    @attendances = current_user.attendances
                               .starts_after(params[:use_start_at] ? @start_at : nil) # 開始時刻での絞り込み
                               .ends_before(params[:use_end_at] ? @end_at : nil) # 終了時刻での絞り込み
                               .page(params[:page]).per(30).includes(:user).order(start_at: :desc)
  end

  # admin
  def index
    if params[:start_at].present? && params[:start_at]['year'].present? && params[:end_at].present? && params[:end_at]['year'].present?
      @start_at =  Time.mktime params[:start_at]["year"].to_i, params[:start_at]["month"].to_i, params[:start_at]["day"].to_i, 00, 00, 00
      @end_at   =  Time.mktime params[:end_at]["year"].to_i, params[:end_at]["month"].to_i, params[:end_at]["day"].to_i, 23, 59, 59
    end

    embossed = 
      case params[:embossed]
      when 'embossed_unfinish'
        false
      when 'embossed_finish'
        true
      when ''
        nil
      end

    approval =
      case params[:approval]
      when 'approved'
        true
      when 'unapproved'
        false
      when ''
        nil
      end

    @attendances = Attendance.get_by_user(params[:user_id]) # ユーザーIDでの絞り込み
                             .has_embossed(embossed) # 打刻状況での絞り込み
                             .is_approved(approval) # 承認状況での絞り込み
                             .starts_after(params[:use_start_at] ? @start_at : nil) # 開始時刻での絞り込み
                             .ends_before(params[:use_end_at] ? @end_at : nil) # 終了時刻での絞り込み
                             .page(params[:page]).per(100).includes(:user).order(start_at: :desc)
  end

  # 勤怠詳細 ====================================================================================================================

  # user & admin 詳細
  def show
    @attendance = Attendance.find(params[:id])
  end

  # admin 削除
  def destroy    
  end

  # user 申請
  def request_status_change
    @attendance = current_user.latest_attendance
    if @attendance.request == "unapplied"
       @attendance.update(request: true)
    end
    redirect_to users_path(current_user.id) and return
  end

  # admin　勤怠承認
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

  # ==============================================================================================================================

  private

  def attendance_params
    params.require(:attendance).permit(:start_at, :end_at, :user_id, :request, :approval, :edit)
  end

  def authenticate_all
    user_signed_in? || admin_signed_in?
  end

end

