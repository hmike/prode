class AddAvatarToTeams < ActiveRecord::Migration
  def change
    add_attachment :teams, :avatar
  end
end
