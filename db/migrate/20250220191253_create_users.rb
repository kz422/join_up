class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :department
      t.string :position
      t.string :icon_url

      t.timestamps
    end
  end
end
