class AddUsesCountToUrls < ActiveRecord::Migration[7.0]
  def self.up
    add_column :urls, :uses_count, :integer, null: false, default: 0
  end

  def self.down
    remove_column :urls, :uses_count
  end
end
