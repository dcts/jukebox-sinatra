class Album
  attr_reader :album_id, :title, :tracks, :artist

  def initialize(attributes = {})
    @album_id = attributes[:album_id]
    @title = attributes[:title]
    @tracks = []
  end

  def add_track(track)
    @tracks << track
  end

  def add_artist(artist)
    artist.add_album(self)
    @artist = artist
  end

  def to_s
    str = "  "
    str << "album_id: #{@album_id} "
    str << "title: #{@title} "
  end
end
