# == Route Map
#
#                       Prefix Verb     URI Pattern                               Controller#Action
#             new_user_session GET      /users/sign_in(.:format)                  devise/sessions#new
#                 user_session POST     /users/sign_in(.:format)                  devise/sessions#create
#         destroy_user_session DELETE   /users/sign_out(.:format)                 devise/sessions#destroy
#                user_password POST     /users/password(.:format)                 devise/passwords#create
#            new_user_password GET      /users/password/new(.:format)             devise/passwords#new
#           edit_user_password GET      /users/password/edit(.:format)            devise/passwords#edit
#                              PATCH    /users/password(.:format)                 devise/passwords#update
#                              PUT      /users/password(.:format)                 devise/passwords#update
#     cancel_user_registration GET      /users/cancel(.:format)                   devise/registrations#cancel
#            user_registration POST     /users(.:format)                          devise/registrations#create
#        new_user_registration GET      /users/sign_up(.:format)                  devise/registrations#new
#       edit_user_registration GET      /users/edit(.:format)                     devise/registrations#edit
#                              PATCH    /users(.:format)                          devise/registrations#update
#                              PUT      /users(.:format)                          devise/registrations#update
#                              DELETE   /users(.:format)                          devise/registrations#destroy
#            user_confirmation POST     /users/confirmation(.:format)             devise/confirmations#create
#        new_user_confirmation GET      /users/confirmation/new(.:format)         devise/confirmations#new
#                              GET      /users/confirmation(.:format)             devise/confirmations#show
#         new_api_user_session GET      /api/v1/auth/sign_in(.:format)            devise_token_auth/sessions#new
#             api_user_session POST     /api/v1/auth/sign_in(.:format)            devise_token_auth/sessions#create
#     destroy_api_user_session DELETE   /api/v1/auth/sign_out(.:format)           devise_token_auth/sessions#destroy
#            api_user_password POST     /api/v1/auth/password(.:format)           devise_token_auth/passwords#create
#        new_api_user_password GET      /api/v1/auth/password/new(.:format)       devise_token_auth/passwords#new
#       edit_api_user_password GET      /api/v1/auth/password/edit(.:format)      devise_token_auth/passwords#edit
#                              PATCH    /api/v1/auth/password(.:format)           devise_token_auth/passwords#update
#                              PUT      /api/v1/auth/password(.:format)           devise_token_auth/passwords#update
# cancel_api_user_registration GET      /api/v1/auth/cancel(.:format)             devise_token_auth/registrations#cancel
#        api_user_registration POST     /api/v1/auth(.:format)                    devise_token_auth/registrations#create
#    new_api_user_registration GET      /api/v1/auth/sign_up(.:format)            devise_token_auth/registrations#new
#   edit_api_user_registration GET      /api/v1/auth/edit(.:format)               devise_token_auth/registrations#edit
#                              PATCH    /api/v1/auth(.:format)                    devise_token_auth/registrations#update
#                              PUT      /api/v1/auth(.:format)                    devise_token_auth/registrations#update
#                              DELETE   /api/v1/auth(.:format)                    devise_token_auth/registrations#destroy
#        api_user_confirmation POST     /api/v1/auth/confirmation(.:format)       devise_token_auth/confirmations#create
#    new_api_user_confirmation GET      /api/v1/auth/confirmation/new(.:format)   devise_token_auth/confirmations#new
#                              GET      /api/v1/auth/confirmation(.:format)       devise_token_auth/confirmations#show
#   api_v1_auth_validate_token GET      /api/v1/auth/validate_token(.:format)     devise_token_auth/token_validations#validate_token
#          api_v1_auth_failure GET      /api/v1/auth/failure(.:format)            devise_token_auth/omniauth_callbacks#omniauth_failure
#                              GET      /api/v1/auth/:provider/callback(.:format) devise_token_auth/omniauth_callbacks#omniauth_success
#                              GET|POST /omniauth/:provider/callback(.:format)    devise_token_auth/omniauth_callbacks#redirect_callbacks
#             omniauth_failure GET|POST /omniauth/failure(.:format)               devise_token_auth/omniauth_callbacks#omniauth_failure
#                              GET      /api/v1/auth/:provider(.:format)          redirect(301)
#

Rails.application.routes.draw do

  get 'home', to: 'pages#home'
  get 'about', to: 'pages#about'
  devise_for :users
  namespace :api do
    scope :v1 do
      mount_devise_token_auth_for 'User', at: 'auth'
    end
  end

  namespace :manage do
    get :dashboard, controller: :pages
    resources :beacons, only: %i(index) do
      get :edit, constraints: { beacon_id: /beacons\/.*/ }
      put '/',   constraints: { beacon_id: /beacons\/.*/ }, action: :update
      get '/',   constraints: { beacon_id: /beacons\/.*/ }, action: :show
      put    :activate,   constraints: { beacon_id: /beacons\/.*/ }
      delete :deactivate, constraints: { beacon_id: /beacons\/.*/ }
      # get :register, on: :collection, action: :create
      get :oauth2callback, on: :collection
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
