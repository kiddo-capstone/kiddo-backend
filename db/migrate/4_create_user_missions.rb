class CreateUserMissions < ActiveRecord::Migration[5.2]
  def change
    create_table :user_missions do |t|
      t.references :user, foreign_key: true
      t.references :mission, foreign_key: true

      t.timestamps
    end
  end
end
