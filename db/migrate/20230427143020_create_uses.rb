class CreateUses < ActiveRecord::Migration[7.0]
  def change
    create_table :uses, id: :uuid do |t|
      t.belongs_to :url, type: :uuid, index: true
      
      t.timestamps
    end
  end
end
