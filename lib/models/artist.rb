class Artist
  attr_reader :artist_id, :albums, :name

  def initialize(attributes = {})
    @artist_id = attributes[:artist_id]
    @name = attributes[:name]
    @albums = []
  end

  def add_album(album)
    @albums << album
  end

  def to_s
    str = ""
    str << "artist_id: #{@artist_id} "
    str << "name: #{@name}"
  end
end
