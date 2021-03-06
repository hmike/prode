class ApplicationController < ActionController::Base
	before_action :configure_devise_permitted_parameters, if: :devise_controller?
	
	private
		# Overwriting the sign_out redirect path method
		def after_sign_out_path_for(resource_or_scope)
			new_user_session_path
		end

	protected

	def configure_devise_permitted_parameters
		registration_params = [:name, :lastname, :birthdate, :country, :avatar, :password, :password_confirmation]

		if params[:action] == 'update'
			devise_parameter_sanitizer.for(:account_update) { 
				|u| u.permit(registration_params << :current_password)
			}
		elsif params[:action] == 'create'
			devise_parameter_sanitizer.for(:signup) { 
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

	layout 'default'

	# cancan Exception handler
	rescue_from CanCan::AccessDenied do |exception|
		redirect_to main_app.unauthenticated_root_path, :alert => exception.message
	end

	# leagues helper method
	helper_method :current_leagues

	def current_leagues
		@leagues = League.all
	end

end
