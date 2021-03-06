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
    rs_name = name.downcase.gsub(/[$]/, 's')
    rs_name = rs_name.gsub(/[-]/, ' ')
    rs_name = rs_name.gsub(/[^a-z0-9\s]/, '')
    rs_artist = Artist.where(['name = ?', name]).first

    rg_artist = RapGenius::Artist.new

    if rs_artist == nil || rs_artist.feature_counts.length == 0
      songs = RapGenius.search_by_artist(name)
      rg_name_stripped = ''
      songs.each do |song|
        rg_name_stripped = song.artist.name.downcase.gsub(/[$]/, 's')
        rg_name_stripped = rg_name_stripped.gsub(/[-]/, ' ')
        rg_name_stripped = rg_name_stripped.gsub(/[^a-z0-9\s]/, '')
        if rs_name == rg_name_stripped
          rg_artist = song.artist
          break
        end
      end

      if rs_artist == nil && rg_artist.songs != 0
        rs_artist = Artist.new(:name => rg_name_stripped)
        rs_artist.rg_name = rg_artist.name
        rs_artist.save()
      end

      i = 1;
      while rg_artist.songs(page: i).length != 0 do
        songs = rg_artist.songs(page: i)
        songs.each do |song|
          # Remove this later
          puts song.title
          featured_artists = song.featured_artists
          featured_artists.each do |featured_artist|
            fa_name_stripped = featured_artist.name.downcase.gsub(/[$]/, 's')
            fa_name_stripped = fa_name_stripped.gsub(/[^a-z0-9\s]/, '')
            if fa_name_stripped == rs_name
              next
            end
            fa_artist = Artist.where(['name = ?', fa_name_stripped]).first
            if fa_artist == nil
              fa_artist = Artist.new(:name => fa_name_stripped)
              fa_artist.rg_name = featured_artist.name
              fa_artist.save()
            end
            feature_count = FeatureCount.where(:parent_artist_id => rs_artist.id).where(:featured_artist_id => fa_artist.id).first
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
      featured_artist_name = Artist.where(:id => fc.featured_artist_id).first.rg_name
      fc_hash['featured_artist_name'] = featured_artist_name
      feature_counts << fc_hash
    end

    sorted_feature_counts = feature_counts.sort_by{ |fc| -fc['count'] }
    top_thirty = Array.new
    for i in 0..29
      top_thirty << sorted_feature_counts[i]
    end

    parent_artist_hash = Hash.new
    parent_artist_hash['parent_artist_name'] = rs_artist.rg_name
    parent_artist_hash['top_thirty'] = top_thirty

    respond_with parent_artist_hash
  end
  
end