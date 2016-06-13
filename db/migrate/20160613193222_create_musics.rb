class CreateMusics < ActiveRecord::Migration
  def change
    create_table :musics do |t|
      t.string       :title
      t.references   :user
      t.string       :url
      t.timestamps
    end
  end
end
