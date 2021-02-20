class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :name
      t.string :description
      t.string :type
      t.integer :points

      t.timestamps
    end
  end
end
