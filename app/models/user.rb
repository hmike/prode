class User < ActiveRecord::Base

	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :invitable, :database_authenticatable, :registerable,
			:recoverable, :rememberable, :trackable, 
			:omniauthable, :invitable

	has_many :user_group_members
	has_many :user_groups, :through => :user_group_members

	# for the Group owner relationship
	has_many :user_groups

	validates_uniqueness_of :email, :case_sensitive => false

	has_attached_file :avatar,
		:styles => {
			# :thumb => "40x40>",
			# :medium => "300x300>"
			:thumb => "60x60>",
			:small  => "80x80>",
			:medium => "140x140>",
			:large =>   "300x300>"
		},
	:default_url => "/assets/default_avatar.png"

	# has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "40x40>" }
	validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

	def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
		user = User.where(:provider => auth.provider, :uid => auth.uid).first
		if user
			return user
		else
			registered_user = User.where(:email => auth.info.email).first
			if registered_user
				return registered_user
			else
				user = User.create(#name:auth.extra.raw_info.name,
									provider:auth.provider,
									uid:auth.uid,
									email:auth.info.email,
									password:Devise.friendly_token[0,20],
									)
			end
		end
	end

	def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
		data = access_token.info
		user = User.where(:provider => access_token.provider, :uid => access_token.uid ).first
		if user
			return user
		else
			registered_user = User.where(:email => access_token.info.email).first
			if registered_user
			return registered_user
			else
			user = User.create(name: data["name"],
				provider:access_token.provider,
				email: data["email"],
				uid: access_token.uid ,
				password: Devise.friendly_token[0,20],
			)
			end
		end
	end

	def can_manage_group(user_group)
		user_group.user_id == id
	end

end
