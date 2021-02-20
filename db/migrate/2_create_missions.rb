class CreateMissions < ActiveRecord::Migration[5.2]
  def change
    create_table :missions do |t|
      t.string :name
      t.date :due_date
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
