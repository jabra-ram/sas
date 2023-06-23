class CreateInvitations < ActiveRecord::Migration[6.1]
  def change
    create_table :invitations do |t|
      t.string :email
      t.string :token
      t.datetime :expires_at

      t.timestamps
    end
  end
end
