class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.string :salt
      t.string :username
      t.string :auth_token
      t.string :password_reset_token
      t.datetime :password_reset_at

      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end