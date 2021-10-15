class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.text :body, default: "", null: false

      t.timestamps
    end
  end
end
