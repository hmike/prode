class UserGroupMember < ActiveRecord::Base

	validates :user_group_id, presence: true
	validates :user_id, presence: true
	validates :user_group_id, :uniqueness => {:scope => :user_id, :message => 'El usuario ya pertene al grupo'}
	
	belongs_to :user
	belongs_to :user_group

end
