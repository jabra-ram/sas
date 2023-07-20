# frozen_string_literal: true

# This is create notification migration
class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.integer :recipient_id
      t.integer :sender_id
      t.string :message
      t.boolean :read_status

      t.timestamps
    end
  end
end
