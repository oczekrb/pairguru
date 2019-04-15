class MoviesController < ApplicationController
  before_action :authenticate_user!, only: [:send_info]

  def index
    return @movies = resolve_case(params[:case]) if params.has_key?(:case)
    @movies = Movie.all.decorate
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def send_info
    @movie = Movie.find(params[:id])
    MovieInfoMailer.send_info(current_user, @movie).deliver_now
    redirect_back(fallback_location: root_path, notice: "Email sent with movie info")
  end

  def export
    file_path = "tmp/movies.csv"
    MovieExporter.new.call(current_user, file_path)
    redirect_to root_path, notice: "Movies exported"
  end

  private

  # rubocop:disable Metrics/MethodLength
  def resolve_case(sorting_type)
    case sorting_type
    when "desc"
      soretd_movies = Movie.all.order(title: :desc).decorate
    when "asc"
      soretd_movies = Movie.all.order(:title).decorate
    when "newest"
      soretd_movies = Movie.all.order(released_at: :desc).decorate
    when "oldest"
      soretd_movies = Movie.all.order(:released_at).decorate
    end
    soretd_movies
  end
  # rubocop:enable Metrics/MethodLength
end
