class CreateOpenidUsers < ActiveRecord::Migration[6.1]
    def change
        create_table :openid_users do |t|
            t.string :uid
            t.string :provider
            t.string :name
            t.string :email

            t.timestamps
        end
    end
end