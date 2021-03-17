class CreateRewards < ActiveRecord::Migration[5.2]
  def change
    create_table :rewards do |t|
      t.string :title
      t.string :description
      t.integer :points_to_redeem
      t.boolean :redeemed
      t.references :user, foreign_key: true
      t.references :parent, foreign_key: true

      t.timestamps
    end
  end
end
