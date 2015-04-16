class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.string :rtype
      t.string :length
      t.boolean :transcribed
      t.references :report, index: true
      t.text :note

      t.timestamps
    end
  end
end
