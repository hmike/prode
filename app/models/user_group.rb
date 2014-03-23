class UserGroup < ActiveRecord::Base

	validates :user_id, presence: true
	validates :name, presence: true, uniqueness: { case_sensitive: false }
	validates :league_id, presence: true

	has_many :user_group_members
	has_many :users, :through => :user_group_members

	# for the Group owner relationship
	belongs_to :user

end
