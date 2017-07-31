class CreateProdHistories < ActiveRecord::Migration[5.1]
  def change
    create_table :prod_histories do |t|
      t.string :metrix_a
      t.string :metrix_b
      t.string :result

      t.timestamps
    end
  end
end
