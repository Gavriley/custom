class CreateCustomFields < ActiveRecord::Migration[5.0]
  def change
    create_table :custom_fields do |t|
      t.string :name
      t.string :value
      t.integer :kind, default: 0
      t.integer :order
      t.belongs_to :post
    end
  end
end
