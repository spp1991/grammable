class RemovePictureFromGrams < ActiveRecord::Migration[5.2]
  def change
    remove_column :grams, :picture, :string
  end
end
