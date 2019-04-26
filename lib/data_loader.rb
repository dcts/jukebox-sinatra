require_relative 'models/artist'
require_relative 'models/album'
require_relative 'models/track'
require 'pry-byebug'
require 'sqlite3'

DB = SQLite3::Database.new(File.join(File.dirname(__FILE__), 'db/jukebox.sqlite'))

# load artists -----------------------------------------------------------------
def load_artists
  query = "SELECT id as artist_id, name FROM artists"
  artists = DB.execute(query)
  artists.map! { |row| Artist.new(artist_id: row[0], name: row[1]) }
  return artists
end

# load albums ------------------------------------------------------------------
def load_albums(artists)
  query = "SELECT id AS album_id, title, artist_id FROM albums"
  albums = DB.execute(query)
  albums.map! do |row|
    album = Album.new(album_id: row[0], title: row[1])
    album.add_artist(artists.find { |artist| artist.artist_id == row[2] })
    album
  end
  return albums
end

# load tracks-------------------------------------------------------------------
def load_tracks(albums)
  tracks = DB.execute(load_tracks_sql)
  tracks.map! { |row| build_track(row, albums) }
  return tracks
end

def load_tracks_sql
  <<-SQL
    SELECT t.id AS track_id,
      t.name AS title,
      t.composer,
      t.milliseconds / 60000.0 AS min_length,
      t.unit_price,
      t.bytes/1000000.0 AS megabytes,
      t.album_id AS album_id
    FROM tracks t
  SQL
end

def build_track(row, albums)
  track = Track.new(
    track_id: row[0],
    title: row[1],
    composer: row[2],
    min_length: row[3],
    unit_price: row[4],
    megabytes: row[5]
  )
  track.add_album(albums.find { |album| album.album_id == row[6] })
  return track
end


# DISPLAY ALL ENTRIES-----------------------------------------------------------
# def display_all_entries(artists)
#   artists.each do |artist|
#     puts artist.to_s
#     artist.albums.each do |album|
#       puts album.to_s
#       album.tracks.each do |track|
#         puts track.to_s
#       end
#     end
#   end
# end
