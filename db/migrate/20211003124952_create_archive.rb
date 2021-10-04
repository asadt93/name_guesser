class CreateArchive < ActiveRecord::Migration[5.2]
  def change
    create_table :archives do |t|
      t.string :data
      t.string :timestamp

      t.timestamps
    end
  end
end
