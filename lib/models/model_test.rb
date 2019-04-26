require_relative 'artist'
require_relative 'album'
require_relative 'track'

# generate tracks
t1 = Track.new(
  track_id: 1,
  title: "Hells Bells",
  composer: "Angus Young",
  min_length: 2.34,
  unit_price: 0.99,
  megabytes: 43.2
)
t2 = Track.new(
  track_id: 2,
  title: "Highway to Hell",
  composer: "Angus Young, Dimitri",
  min_length: 3.5,
  unit_price: 0.99,
  megabytes: 12.5
)

# generate album and add to tracks
album1 = Album.new(album_id: 1, title: "Best Of")
album1.add_track(t1)
album1.add_track(t2)

# generate artist and add albums
ac_dc = Artist.new(name: "ac dc", artist_id: 1)
ac_dc.add_album(album1)

artists = []
artists << ac_dc

# display cascading relationship
artists.each do |artist|
  puts artist.to_s
  artist.albums.each do |album|
    puts album.to_s
    album.tracks.each do |track|
      puts track.to_s
    end
  end
end
