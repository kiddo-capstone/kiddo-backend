class CreateMissionTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :mission_tasks do |t|
      t.references :mission, foreign_key: true
      t.references :task, foreign_key: true
      t.string :message
      t.string :image_path
      t.boolean :completed?
      t.timestamps
    end
  end
end
