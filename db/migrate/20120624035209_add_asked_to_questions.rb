class AddAskedToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :asked, :boolean
  end
end
