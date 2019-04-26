class Track
  attr_reader :track_id, :title, :composer, :min_length, :unit_price, :megabytes, :album

  def initialize(attributes = {})
    @track_id = attributes[:track_id]
    @title = attributes[:title]
    @composer = attributes[:composer]
    @min_length = attributes[:min_length]
    @unit_price = attributes[:unit_price]
    @megabytes = attributes[:megabytes]
  end

  def add_album(album)
    album.add_track(self)
    @album = album
  end

  def to_s
    str = "    "
    str << "track_id: #{@track_id} "
    str << "title: #{@title} "
    str << "composer: #{@composer} "
    str << "min_length: #{@min_length} "
    str << "unit_price: #{@unit_price} "
    str << "megabytes: #{@megabytes}"
  end
end
