class UserGroup < ActiveRecord::Base

	validates :user_id, presence: true
	validates :name, presence: true, uniqueness: { case_sensitive: false }

	belongs_to :user
	has_many :user_group_members

end
