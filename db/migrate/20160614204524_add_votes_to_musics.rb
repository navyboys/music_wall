class AddVotesToMusics < ActiveRecord::Migration
  def change
    add_column :musics, :votes, :integer
  end
end
