class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.references :doctor, index: true
      t.string :patientID
      t.string :rtype
      t.string :status

      t.timestamps
    end
  end
end
