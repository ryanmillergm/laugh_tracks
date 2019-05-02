class CreateComedians < ActiveRecord::Migration[5.1]
  def change
    create_table :comedians do |t|
      t.string :name
      t.integer :age
      t.string :city
      t.string :image_url
    end
  end
end
