require 'sinatra'
require 'sinatra/reloader' if development?
require 'sqlite3'
require 'pry-byebug'
require_relative 'data_loader'

# Then:
# 1. Create an artist page with all the albums. Display genres as well
# 2. Create an album pages with all the tracks
# 3. Create a track page with all the track info

# load data with model
artists = load_artists
albums = load_albums(artists)
tracks = load_tracks(albums)

get '/' do
  @artists = artists
  erb :home
end

get '/artists/:id' do
  artist_id = params[:id].to_i
  @artist = artists.select { |item| item.artist_id == artist_id }[0]
  erb :artists
end

get '/albums/:id' do
  album_id = params[:id].to_i
  @album = albums.select { |item| item.album_id == album_id }[0]
  erb :albums
end

get '/tracks/:id' do
  track_id = params[:id].to_i
  @track = tracks.select { |item| item.track_id == track_id }[0]
  erb :tracks
end

