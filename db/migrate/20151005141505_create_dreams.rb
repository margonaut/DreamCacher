class CreateDreams < ActiveRecord::Migration
  def change
    create_table :dreams do |t|
      t.string :title
      t.text :text, null: false
      t.string :sentiment, null: false
      t.date :date, null: false

      t.belongs_to :user, null: false

      t.timestamps null: false
    end
  end
end
