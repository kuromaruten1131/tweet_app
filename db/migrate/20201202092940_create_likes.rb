class CreateLikes < ActiveRecord::Migration[6.0]
  def change
    create_table :likes do |t|
      t.references :tweet
      t.references :user

      t.timestamps
    end
  end
end
