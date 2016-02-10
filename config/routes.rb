require 'api_constraints'

Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'
  #
  root :to => "static_pages#home"
  # get 'static_pages/home'
  #

  namespace :api, defaults: { format: :json }, path: '/' do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do


    end

    match '*path', to: -> (env) {
    [400, { 'Content-Type' => 'application/json' },
      [{ status: 404, error: 'Route Not Found' }.to_json]]
      }, via: :all
  end
end
