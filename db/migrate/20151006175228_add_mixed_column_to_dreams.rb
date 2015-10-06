class AddMixedColumnToDreams < ActiveRecord::Migration
  def change
    add_column :dreams, :mixed, :boolean, default: false
  end
end
