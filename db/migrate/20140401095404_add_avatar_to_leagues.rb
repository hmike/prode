class AddAvatarToLeagues < ActiveRecord::Migration
  def change
    add_attachment :leagues, :avatar
  end
end
