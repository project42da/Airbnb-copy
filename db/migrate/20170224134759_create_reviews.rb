class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.text :comment
      t.integer :cleanliness, default: 5
      t.integer :location, default: 5
      t.integer :accuracy, default: 5
      t.integer :value, default: 5
      t.references :room, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
