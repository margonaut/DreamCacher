class AddUniqueIndexToKeywords < ActiveRecord::Migration
  def change
    add_index :keywords, :text, unique: true
  end
end
