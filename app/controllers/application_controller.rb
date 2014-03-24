class ApplicationController < ActionController::Base
   before_action :configure_devise_permitted_parameters, if: :devise_controller?

  protected

  def configure_devise_permitted_parameters
    registration_params = [:name, :birthday, :country, :avatar, :email, :password, :password_confirmation]

    if params[:action] == 'update'
      devise_parameter_sanitizer.for(:account_update) { 
        |u| u.permit(registration_params << :current_password)
      }
    elsif params[:action] == 'create'
      devise_parameter_sanitizer.for(:sign_up) { 
        |u| u.permit(registration_params) 
      }
    end
  end

    # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  protect_from_forgery

  after_filter :set_csrf_cookie_for_ng
  def set_csrf_cookie_for_ng
    cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  end

  protected
    def verified_request?
      super || form_authenticity_token == request.headers['X-XSRF-TOKEN']
	end

  # layout 'superhero'
  layout 'yeti'

end
