Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'root#top'

  # 管理者用
  devise_for :admins, path: 'devise_admins',
    controllers: {
      sessions: 'devise_admins/sessions',
      passwords: 'devise_admins/passwords'
    }

  as :admin do
    get 'devise_admins/edit', to:'devise_admins/registrations#edit', as: 'edit_admin_registration'
    put 'devise_admins', to:'devise_admins/registrations#update', as: 'admin_registration'
  end

  get 'admin', to: 'admins#top', as: 'admin'
  get 'users/index'

  # ユーザー用
  devise_for :users, path: 'devise_users',
    controllers: {
      sessions: 'devise_users/sessions',
      passwords: 'devise_users/passwords',    
      registrations: 'devise_users/registrations'
    }

  get 'users/:id', to: 'users#top', as: 'users'

  # 勤怠
  resources :attendances
  post 'attendances/start_attendance',            to: 'attendances#start_attendance',       as: :attendance_start_attendance
  patch 'attendances/:id/end_attendance',         to: 'attendances#end_attendance',         as: :attendance_end_attendance
  patch 'attendances/:id/request_status_change',  to: 'attendances#request_status_change',  as: :attendance_request_status_change
  patch 'attendances/:id/approval_status_change', to: 'attendances#approval_status_change', as: :attendance_approval_status_change
 
end