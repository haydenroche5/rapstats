class ArtistsController < ApplicationController

  def index
    respond_with Artist.all
  end

  def create
    respond_with Artist.create(artist_params)
  end

  def show
    respond_with Artist.find(:first, :conditions => ['name = ?', params[:name]])
  end

  def search
    puts 'got here in rails'
    puts 'weeeeee'
    puts 'weeeeee'
    puts 'weeeeee'
    puts 'weeeeee'
    name = params[:name]
    puts name
    respond_with Artist.all
=begin
    artist = Artist.find(:first, :conditions => ['name = ?', name])
    if artist != nil
      if artist.feature_counts.empty?
        begin
          result = RapGenius.search_by_artist(name)
        rescue StandardError => e
          puts 'Error: #{e}'
        else
          songs = result.songs
          for songs.each do |song|
            puts song.title
          end
        end
      end
    else
      begin
        result = RapGenius.search_by_artist(name)
      rescue StandardError => e
        puts 'Error: #{e}'
      else
        songs = result.songs
        for songs.each do |song|
          puts song.title
        end
      end
    end
=end
  end
  
  private
  def artist_params
    params.requrie(:artist).permit(:name)
  end
end
