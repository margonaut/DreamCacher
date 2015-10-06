class CreateKeywords < ActiveRecord::Migration
  def change
    create_table :keywords do |t|
      t.string :text, null: false

      t.timestamps
    end
  end
end
