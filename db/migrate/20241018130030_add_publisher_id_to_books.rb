class AddPublisherIdToBooks < ActiveRecord::Migration[7.2]
  def change
    add_reference :books, :publisher, foreign_key: true
    change_column :books, :publisher_id, :integer, null: false
  end
end
