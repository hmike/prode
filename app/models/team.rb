class Team < ActiveRecord::Base

	validates :name, presence: true, uniqueness: { case_sensitive: false }
	validates :code, presence: true, uniqueness: { case_sensitive: false }
	validates :country, presence: true
	validates :avatar, presence: true

end
