class CreatePhrases < ActiveRecord::Migration
  def change
    create_table :phrases do |t|
      t.string :english
      t.string :kannada
      t.string :tamil
      t.string :tamil_alt
      t.integer :chapter_id

      t.timestamps
    end
  end
end
