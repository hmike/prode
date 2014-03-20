class League < ActiveRecord::Base

	validates :name, presence: true, uniqueness: { case_sensitive: false }
	validates :league_type, presence: true
	validates :groups_count, presence: true
	validates :teams_count, presence: true

	has_and_belongs_to_many :teams

end
