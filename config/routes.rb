Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_for :admins, path: 'devise_admins',
    controllers: {
      sessions: 'devise_admins/sessions',
      passwords: 'devise_admins/passwords'
    }

  as :admin do
    get 'devise_admins/edit', to:'devise_admins/registrations#edit', as: 'edit_admin_registration'
    put 'devise_admins', to:'devise_admins/registrations#update', as: 'admin_registration'
  end

  root 'root#top'

  get 'admin', to: 'admins#top', as: 'admin'
  
end
