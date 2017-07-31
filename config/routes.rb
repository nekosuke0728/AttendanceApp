Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'root#top'

  get 'admin', to: 'admins#top', as: 'admin'

  devise_for :admins, path: 'devise_admins',
    controllers: {
      sessions: 'devise_admins/sessions',
      passwords: 'devise_admins/passwords'
    }
    
  as :admin do
    get 'devise_admins/edit', to:'devise_admins/registrations#edit', as: 'edit_admin_registration'
    put 'devise_admins', to:'devise_admins/registrations#update', as: 'admin_registration'
  end

  get 'users/:id', to: 'users#top', as: 'users'

  devise_for :users, path: 'devise_users',
    controllers: {
      sessions: 'devise_users/sessions',
      passwords: 'devise_users/passwords',    
      registrations: 'devise_users/registrations'
    }
 
end