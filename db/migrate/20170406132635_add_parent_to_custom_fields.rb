class AddParentToCustomFields < ActiveRecord::Migration[5.0]
  def change
    add_column(:custom_fields, :parent_id, :integer)
    add_index(:custom_fields, :parent_id)
  end
end
