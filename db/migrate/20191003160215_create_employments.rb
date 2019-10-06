class CreateEmployments < ActiveRecord::Migration[6.0]
  def change
    create_table :employments do |t|
      t.integer :year
      t.string :collectivity
      t.string :contract_type
      t.string :position
      t.string :level, default: "-"
      t.string :speciality, default: "-"
      t.integer :men_number
      t.integer :women_number
      t.boolean :enriched, default: false

      t.timestamps
    end
  end
end
