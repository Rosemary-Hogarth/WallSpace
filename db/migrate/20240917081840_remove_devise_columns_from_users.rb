class RemoveDeviseColumnsFromUsers < ActiveRecord::Migration[7.1]
    def change
      remove_column :users, :encrypted_password if column_exists?(:users, :encrypted_password)
      remove_column :users, :reset_password_token if column_exists?(:users, :reset_password_token)
      remove_column :users, :reset_password_sent_at if column_exists?(:users, :reset_password_sent_at)
      remove_column :users, :remember_created_at if column_exists?(:users, :remember_created_at)
      remove_column :users, :sign_in_count if column_exists?(:users, :sign_in_count)
      remove_column :users, :current_sign_in_at if column_exists?(:users, :current_sign_in_at)
      remove_column :users, :last_sign_in_at if column_exists?(:users, :last_sign_in_at)
      remove_column :users, :current_sign_in_ip if column_exists?(:users, :current_sign_in_ip)
      remove_column :users, :last_sign_in_ip if column_exists?(:users, :last_sign_in_ip)
    end
  end
