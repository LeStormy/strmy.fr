class CreateUrls < ActiveRecord::Migration[7.0]
  def change
    create_table :urls, id: :uuid do |t|
      t.string :target
      t.string :code
      
      t.timestamps
    end
  end
end
