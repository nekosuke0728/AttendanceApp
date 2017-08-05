Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'root#top'

  # get 'admin', to: 'admins#top', as: 'admin'
  authenticated :admin do
    root 'admins#top', as: 'admin'
  end

  get 'users/:id', to: 'users#top', as: 'users'
  # authenticated :user do
  #   root 'users/:id', to: 'users#top', as: 'users'
  # end

  devise_for :admins, path: 'devise_admins',
    controllers: {
      sessions: 'devise_admins/sessions',
      passwords: 'devise_admins/passwords'
    }

  as :admin do
    get 'devise_admins/edit', to:'devise_admins/registrations#edit', as: 'edit_admin_registration'
    put 'devise_admins', to:'devise_admins/registrations#update', as: 'admin_registration'
  end

  devise_for :users, path: 'devise_users',
    controllers: {
      sessions: 'devise_users/sessions',
      passwords: 'devise_users/passwords',    
      registrations: 'devise_users/registrations'
    }

  resources :attendances
  post 'attendances/start',                      to: 'attendances#start',                 as: :attendance_start
  patch 'attendances/:id/end',                   to: 'attendances#end',                   as: :attendance_end
  patch 'attendances/:id/request_status_change', to: 'attendances#request_status_change', as: :attendance_request_status_change
 
end