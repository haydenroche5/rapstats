class CreateArists < ActiveRecord::Migration
  def change
    create_table :arists do |t|
      t.string :name

      t.timestamps
    end
  end
end
