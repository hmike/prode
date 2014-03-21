class Team < ActiveRecord::Base

	validates :name, presence: true, uniqueness: { case_sensitive: false }
	validates :code, presence: true, uniqueness: { case_sensitive: false }
	validates :country, presence: true
	validates :avatar, presence: true

	has_and_belongs_to_many :leagues

	has_many :local_team_matches, :foreign_key => :local_team, :class_name => 'Match'
	has_many :away_team_matches, :foreign_key => :away_team, :class_name => 'Match'
 
end
