class CreateMissions < ActiveRecord::Migration[5.2]
  def change
    create_table :missions do |t|
      t.string :name
      t.date :due_date
      t.boolean :expired?
      t.timestamps
    end
  end
end
