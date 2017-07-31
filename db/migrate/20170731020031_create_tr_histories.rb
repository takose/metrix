class CreateTrHistories < ActiveRecord::Migration[5.1]
  def change
    create_table :tr_histories do |t|
      t.string :metrix
      t.integer :result

      t.timestamps
    end
  end
end
