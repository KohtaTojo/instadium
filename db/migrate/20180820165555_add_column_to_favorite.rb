class AddColumnToFavorite < ActiveRecord::Migration[5.2]
  def change
    add_column :favorites, :favorited_user_id, :integer
  end
end
