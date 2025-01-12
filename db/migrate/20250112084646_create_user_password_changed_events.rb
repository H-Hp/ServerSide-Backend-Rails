class CreateUserPasswordChangedEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :user_password_changed_events do |t|
      t.integer :es_test_id
      t.string :old_password_digest
      t.string :new_password_digest
      t.datetime :changed_at

      t.timestamps
    end
  end
end
