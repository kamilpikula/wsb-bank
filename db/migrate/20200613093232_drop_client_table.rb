class DropClientTable < ActiveRecord::Migration[6.0]
  def change
    drop_table :clients
  end
end
