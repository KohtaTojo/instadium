class AddPictureRefToThumbnail < ActiveRecord::Migration[5.2]
  def change
    add_reference :thumbnails, :picture, foreign_key: true
  end
end
