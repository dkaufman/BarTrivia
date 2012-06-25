class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.string :body
      t.integer :question_id
      t.integer :team_id

      t.timestamps
    end
  end
end
