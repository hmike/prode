class League < ActiveRecord::Base

	validates :name, presence: true, uniqueness: { case_sensitive: false }
	validates :league_type, presence: true
	validates :groups_count, presence: true
	validates :teams_count, presence: true

	has_and_belongs_to_many :teams

	has_many :matches
	has_many :user_groups

	has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "40x40>" }
	validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

	def avatar_thumb_url; avatar.url(:thumb);	end

	# The max league.date_count based on the current matches
	def dates_count;	self.matches.order('league_date DESC').pluck(:league_date).first	end

end
