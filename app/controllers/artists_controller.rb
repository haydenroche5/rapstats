class ArtistsController < ApplicationController

  def index
    respond_with Artist.all
  end

  def create
    respond_with Artist.create(artist_params)
  end

  def show
    respond_with Artist.first(:conditions => ['name = ?', params[:name]])
  end

  def search
    name = params[:name]
    rs_artist = Artist.where(['name = ?', name]).first

    if rs_artist == nil
      songs = RapGenius.search_by_artist(name)
      rs_name = name.downcase.gsub(/[$]/, 's')
      rs_name = rs_name.gsub(/[^a-z0-9\s]/, '')
      rg_name = ''
      rg_artist = RapGenius::Artist.new
      songs.each do |song|
        rg_name = song.artist.name.downcase.gsub(/[$]/, 's')
        rg_name = rg_name.gsub(/[^a-z0-9\s]/, '')
        if rs_name == rg_name
          rg_artist = song.artist
          break
        end
      end
      
      if rg_artist.songs != 0
        rs_artist = Artist.create(:name => rg_name)
      end

      i = 1;
      while rg_artist.songs(page: i).length != 0 do
        songs = rg_artist.songs(page: i)
        songs.each do |song|
          puts song.title
          featured_artists = song.featured_artists
          featured_artists.each do |featured_artist|
            fa_name = featured_artist.name.downcase.gsub(/[$]/, 's')
            fa_name = fa_name.gsub(/[^a-z0-9\s]/, '')
            if fa_name == rs_name
              next
            end
            fa_artist = Artist.where(['name = ?', fa_name]).first
            if fa_artist == nil
              fa_artist = Artist.create(:name => fa_name)
            end
            feature_count = FeatureCount.where(:parent_artist_id=>rs_artist.id).where(:featured_artist_id=>fa_artist.id).first
            if feature_count != nil
              feature_count.count = feature_count.count + 1
              feature_count.save()
            else
              fc = FeatureCount.new(:count => 1)
              fc.parent_artist_id = rs_artist.id
              fc.featured_artist_id = fa_artist.id
              fc.save()
              rs_artist.feature_counts << fc
              rs_artist.save()
            end
          end
        end
        i = i + 1
      end
    end
    feature_counts = Array.new
    rs_artist.feature_counts.each do |fc|
      fc_hash = Hash.new
      fc_hash['count'] = fc.count
      parent_artist_name = Artist.where(:id => fc.parent_artist_id).first.name
      featured_artist_name = Artist.where(:id => fc.featured_artist_id).first.name
      fc_hash['parent_artist_name'] = parent_artist_name
      fc_hash['featured_artist_name'] = featured_artist_name
      feature_counts << fc_hash
    end
    feature_counts.sort_by(&:count)
    respond_with feature_counts.to_json
  end
  
  private
  def artist_params
    params.require(:artist).permit(:name)
  end
end