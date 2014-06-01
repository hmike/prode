class RegistrationsController < Devise::RegistrationsController

	def update
		account_update_params = devise_parameter_sanitizer.sanitize(:account_update)
			
		# required for settings form to submit when password is left blank
		if account_update_params[:password].blank?
			account_update_params.delete("password")
			account_update_params.delete("password_confirmation")
		end
	
		@user = User.find(current_user.id)
		if @user.update_attributes(account_update_params)
			set_flash_message :notice, :updated
			# Sign in the user bypassing validation in case his password changed
			sign_in @user, :bypass => true
			
			respond_to do |format|
				format.html { redirect_to edit_registration_path(@user) }
				# format.json { respond_with_bip(@user) }
				format.json { render :json => { :status => :ok }}
			end
	
		else
			render 'edit'
		end
	end

end