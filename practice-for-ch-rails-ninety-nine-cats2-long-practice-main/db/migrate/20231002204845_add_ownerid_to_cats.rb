class AddOwneridToCats < ActiveRecord::Migration[7.0]
  def change
    add_column :cats, :owner_id, :integer
    add_foreign_key :cats, :users, column: :owner_id
    # add_foreign_key :cats, :owner, foreign_key: {to_table: :users}
  end
end
