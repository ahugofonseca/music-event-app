class CreateMusicEventArtists < ActiveRecord::Migration[5.2]
  def change
    create_table :music_event_artists do |t|
      t.references :artist, foreign_key: true
      t.references :music_event, foreign_key: true

      t.timestamps
    end
  end
end
