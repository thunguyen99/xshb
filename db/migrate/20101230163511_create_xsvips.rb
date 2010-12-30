class CreateXsvips < ActiveRecord::Migration
  def self.up
    create_table :xsvips do |t|
      t.integer :user_id
      t.string :card_number
      t.string :card_password
      t.string :receiver
      t.string :mobile
      t.string :address
      t.timestamps
    end
  end

  def self.down
    drop_table :xsvips
  end
end
