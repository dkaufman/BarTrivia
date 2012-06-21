class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :body
      t.string :solution
      t.string :category
      t.integer :game_id

      t.timestamps
    end
  end
end
