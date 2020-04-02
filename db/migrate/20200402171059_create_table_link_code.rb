class CreateTableLinkCode < ActiveRecord::Migration[5.2]
  def change
    create_table :link_codes do |t|
      t.string :code
      t.boolean :status
      t.string :link_type
      t.integer :linkable_id
      t.string :linkable_type
      t.datetime :expire_at

      t.timestamps
    end
  end
end
