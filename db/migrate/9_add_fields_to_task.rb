class AddFieldsToTask < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :resource_link, :string
    add_column :tasks, :resource_alt, :string
    add_column :tasks, :resource_type, :string
  end
end
