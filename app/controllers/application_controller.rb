class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include ApplicationHelper
  include DeviseHelper
  include CheckinsHelper

  before_action :configure_permitted_parameters, if: :devise_controller?

  before_action :authenticate_user!

  layout :layout_by_resource


  protected

  # Permit the devise parameters.
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me, :name, :gender, :phone_no, :role_id, :max_leaves, :image) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:password, :password_confirmation, :current_password) }
  end

  # Takes default layout as sign_in if user is not signed in.
  def layout_by_resource
    if devise_controller? && !user_signed_in?
      "sign_in"
    else
      "application"
    end
  end

end
