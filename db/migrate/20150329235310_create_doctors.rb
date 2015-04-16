class CreateDoctors < ActiveRecord::Migration
  def change
    create_table :doctors do |t|
      t.string :name
      t.string :password_digest
      t.string :email
      t.string :photo

      t.timestamps
    end
  end
end
