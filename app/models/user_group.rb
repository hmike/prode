class UserGroup < ActiveRecord::Base

	belongs_to :user

	validates :user_id, presence: true
	validates :name, presence: true, uniqueness: { case_sensitive: false }

end
