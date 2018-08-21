class RemoveImageFromPictures < ActiveRecord::Migration[5.2]
  def change
    remove_column :pictures, :image, :text
  end
end
