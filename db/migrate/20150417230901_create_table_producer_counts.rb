class CreateTableProducerCounts < ActiveRecord::Migration
  def change
    create_table :producer_counts do |t|
      t.integer :count
      t.references :artist, index: true
      t.references :producer, index: true

      t.timestamps
    end
  end
end
