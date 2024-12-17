class CreateUserJwts < ActiveRecord::Migration[6.1]
  def change
    create_table :user_jwts do |t|
      t.string :email
      t.string :password_digest
      t.string :auth_token

      t.timestamps
    end
  end
end
