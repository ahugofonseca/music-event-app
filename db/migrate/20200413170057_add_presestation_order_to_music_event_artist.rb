class AddPresestationOrderToMusicEventArtist < ActiveRecord::Migration[5.2]
  def change
    add_column :music_event_artists, :presentation_order, :integer, default: 1
  end
end
