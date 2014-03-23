class AddIsPlayoffToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :is_playoff, :boolean
  end
end
