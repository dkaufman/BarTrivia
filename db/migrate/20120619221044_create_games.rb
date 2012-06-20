class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :name
      t.string :status, default: :active

      t.timestamps
    end
  end
end
