class CreateEmployments < ActiveRecord::Migration[6.0]
  def change
    create_table :employments do |t|
      t.integer :year
      t.string :collectivity
      t.string :contract_type
      t.string :position
      t.string :level
      t.string :speciality
      t.string :men_number
      t.string :women_number

      t.timestamps
    end
  end
end
