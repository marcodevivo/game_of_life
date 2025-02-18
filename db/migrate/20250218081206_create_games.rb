class CreateGames < ActiveRecord::Migration[7.0]
  def change
    create_table :games do |t|
      t.integer :current_generation
      t.integer :rows
      t.integer :cols
      t.integer :number_of_generations, default: 0
      t.timestamps
    end
  end
end
