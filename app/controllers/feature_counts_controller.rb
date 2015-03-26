class FeatureCountsController < ApplicationController

  def create
    parent_artist = Artist.find(params[:parent_artist_id])
    # featured_artist = Artist.find(params[:featured_artist_id])
    feature_count = parent_artist.feature_counts.create(feature_count_params)

    respond_with parent_artist, feature_count
  end

  def increase_count
    parent_artist = Artist.find(params[:parent_artist_id])
    feature_count = FeatureCounts.find(params[:id])
    feature_count.increment!(:count)

    respond_with parent_artist, feature_count
  end

  private
  def feature_count_params
    params.require(:feature_count).permit(:parent_artist_id, :featured_artist_id)
  end
  
end
