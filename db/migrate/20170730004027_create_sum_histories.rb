class CreateSumHistories < ActiveRecord::Migration[5.1]
  def change
    create_table :sum_histories do |t|
      t.string :metrix_a
      t.string :metrix_b
      t.string :result

      t.timestamps
    end
  end
end
