class CreateAlbums < ActiveRecord::Migration
  def self.up
    create_table :albums do |t|
      t.string :title
      t.text :memo
      t.timestamps
    end
  end

  def self.down
    drop_table :albums
  end
end
