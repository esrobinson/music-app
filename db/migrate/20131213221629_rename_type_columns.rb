class RenameTypeColumns < ActiveRecord::Migration
  def change
    rename_column :albums, :type, :recording_type
    rename_column :tracks, :type, :bonus
  end
end
