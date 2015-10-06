class CreateDreamsKeywords < ActiveRecord::Migration
  def change
    create_table :dreams_keywords do |t|
      t.belongs_to :dream, null: false
      t.belongs_to :keyword, null: false
      t.string :relevance, null: false
      t.string :sentiment, default: 0

      t.timestamps
    end
  end
end
