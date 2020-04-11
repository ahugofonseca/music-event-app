class CreateMusicEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :music_events do |t|
      t.string :local
      t.datetime :scheduled_date_time
      t.integer :event_type
      t.text :genres, array: true, default: []

      t.timestamps
    end
    add_index :music_events, :genres, using: 'gin'
  end
end
