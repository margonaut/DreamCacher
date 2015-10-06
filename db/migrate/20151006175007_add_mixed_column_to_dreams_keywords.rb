class AddMixedColumnToDreamsKeywords < ActiveRecord::Migration
  def change
    add_column :dreams_keywords, :mixed, :boolean, default: false
  end
end
