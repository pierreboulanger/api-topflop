class Api::V1::BaseController < ActionController::API
  include Pundit

  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index

  rescue_from StandardError,                with: :internal_server_error
  rescue_from Pundit::NotAuthorizedError,   with: :user_not_authorized
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  private

  def user_not_authorized(exception)
    render json: {
      error: "Unauthorized #{exception.policy.class.to_s.underscore.camelize}.#{exception.query}"
    }, status: :unauthorized
  end

  def not_found(exception)
    render json: { error: exception.message }, status: :not_found
  end

  def internal_server_error(exception)
    if Rails.env.development?
      response = { type: exception.class.to_s, message: exception.message, backtrace: exception.backtrace }
    else
      response = { error: "Internal Server Error" }
    end
    render json: response, status: :internal_server_error
  end
end
1ST ENDPOINT: INDEX
GET /api/v1/restaurants  # unauthenticated
# config/routes.rb
Rails.application.routes.draw do
  # [...]
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :restaurants, only: [ :index ]
    end
  end
end
CONTROLLER (1)
touch app/controllers/api/v1/restaurants_controller.rb
mkdir -p app/views/api/v1/restaurants
2ND ENDPOINT: SHOW
GET /api/v1/restaurants/:id # unauthenticated
# config/routes.rb
Rails.application.routes.draw do
  # [...]
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :restaurants, only: [ :index, :show ]
    end
  end
end
3RD ENDPOINT: UPDATE
PATCH /api/v1/restaurants/:id # authenticated
HAPPY API-ING!
