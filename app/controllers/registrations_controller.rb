# Overrides devise update method, para que funque con best_in_place, porque el hdp de devise
# pide por default que para editar un campo le mandes la contraseña actual,
# con esto, no la pide. Para hacer override hay que tocar en routes tmb
class RegistrationsController < Devise::RegistrationsController

	def create
		Rails.logger.debug "********************************************************"
		Rails.logger.debug @user.inspect
		Rails.logger.debug "********************************************************"
		return;
	end

	def update
		account_update_params = devise_parameter_sanitizer.sanitize(:account_update)

		# required for settings form to submit when password is left blank
		if account_update_params[:password].blank?
			account_update_params.delete("password")
			account_update_params.delete("password_confirmation")
		end

		@user = User.find(current_user.id)
		# respond_to do |format|
			if @user.update_attributes(account_update_params)
				set_flash_message :notice, :updated
				# Sign in the user bypassing validation in case his password changed
				sign_in @user, :bypass => true
				
				respond_with_success('OKKKK!!')

				# format.html { redirect_to edit_registration_path(@user) }
				# format.json { respond_with_bip(@user) }
				# format.json { render :json => {"model" => @user } }
			else
				# format.html { redirect_to edit_registration_path(@user) }
				# format.json { render json: @user.errors, status: :unprocessable_entity }
			end
		# end
	end

	# respond back to the client an http 200 status plus the message
	def respond_with_success(messages)
		respond_with_messages(messages, 'success', :ok)
		# respond_to do |format|
		#   # render :json => {:errors => errors}, :status => :bad_request
		#   format.html { render notice: message }
		#   format.json { render :json => build_json_errors(message, severity), :status => :ok }
		# end
	end

	# respond back to the client an http 400 status plus the errors array
	def respond_with_errors(errors)
		respond_with_messages(errors, 'success', :bad_request)
		# respond_to do |format|
		#   # render :json => {:errors => errors}, :status => :bad_request
		#   format.html { render notice: errors }
		#   format.json { render :json => build_json_errors(errors, severity), :status => :bad_request }
		# end
	end

	def respond_with_messages(messages, severity, status)
		respond_to do |format|
			format.html { render notice: messages }
			format.json { render :json => build_json_messages(messages, severity), :status => status }
		end
	end

	def build_json_messages(errors, severity)
		if (errors.kind_of?(String))
				# if it's just an string, return it as errors
				return { :messages => [
					{ :text => errors, :severity => severity }
				]
			}

		else
				# if not, build the proper json for each array elem
				errors_arr = Array.new
				errors.each do |key, msg|
					errors_arr.push({ :text => "#{msg}", :severity => severity })
				end
				return { :messages => errors_arr }
			end
		end
end