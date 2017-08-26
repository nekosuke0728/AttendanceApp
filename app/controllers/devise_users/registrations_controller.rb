class DeviseUsers::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # prepend_before_action :require_no_authentication, :only => [ :cancel]
  # prepend_before_action :authenticate_scope!, :only => [:new, :create ,:edit, :update, :destroy]

  prepend_before_action :require_no_authentication, :only => [:new, :create, :cancel, :destroy]
  prepend_before_action :authenticate_scope!, :only => [:edit, :update]

  before_action :redirect_if_not_admin, only: [:new, :create, :cancel]
  before_action :configure_permitted_parameters

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    build_resource(sign_up_params)

    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        # sign_up(resource_name, resource)
        # respond_with resource, location: after_sign_up_path_for(resource)

        # mailer
        AccountMailer.account_email(resource).deliver

        # devise override
        # （サインアップしたユーザーでログインせずadminページにリダイレクト）
        redirect_to admin_path

      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  def redirect_if_not_admin
    unless admin_signed_in?
      redirect_to root_path
      return
    end
  end

  # Devise Gem override
  # # deviseのcontrollerを継承したcontroller内では認証が実行されないようになっているため
  # def authenticate_admin!
  #   if admin_signed_in?
  #     super
  #   else
  #     redirect_to user_session_path
  #   end
  # end

  # userモデルのカラムに追加した内容
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :birthday, :gender, :employment_status, :address, :phone])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :birthday, :gender, :employment_status, :address, :phone])
  end

  
  def after_update_path_for(resource)
    users_path(current_user.id)
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
