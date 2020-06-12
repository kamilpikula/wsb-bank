class ChangeUsernameColumn < ActiveRecord::Migration[6.0]
  def change
    rename_column :users, :useranme, :username
  end
end
