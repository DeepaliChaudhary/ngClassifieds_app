class CreateClassifieds < ActiveRecord::Migration
  def change
    create_table :classifieds do |t|
      t.string :title
      t.string :description
      t.string :price
      t.date :posted
      t.string :contact
      t.string :categories
      t.string :image
      t.string :views
      t.timestamps
    end
  end
end
