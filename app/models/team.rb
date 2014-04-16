class Team < ActiveRecord::Base

	validates :name, presence: true, uniqueness: { case_sensitive: false }
	# validates :code, presence: true, uniqueness: { case_sensitive: false }
	validates :code, presence: true
	validates :country, presence: true
	validates :avatar, presence: true

	has_and_belongs_to_many :leagues

	# has_many :local_team_matches, :foreign_key => 'local_team_id', :class_name => 'Match'
	# has_many :away_team_matches, :foreign_key => 'away_team_id', :class_name => 'Match'

	has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "40x40>" }
	validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
	# validates_attachment_content_type :avatar, :content_type => 'image/png'
 
	def accessible_attributes
	 [:name, :code ]
	end

end
