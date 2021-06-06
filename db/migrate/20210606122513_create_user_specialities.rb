class CreateUserSpecialities < ActiveRecord::Migration[5.2]
  def change
    create_table :user_specialities do |t|
      t.integer :user_id
      t.integer :speciality_id

      t.timestamps
    end
  end
end
