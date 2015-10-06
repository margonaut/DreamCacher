class AddUniqueIndexToDreamsKeywords < ActiveRecord::Migration
  def change
    add_index :dreams_keywords, [:dream_id, :keyword_id], unique: true
  end
end
