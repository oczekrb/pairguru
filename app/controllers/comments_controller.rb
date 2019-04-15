class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_movie

  def create
    @comment = @movie.comments.create(comment_params)
    @comment.user = current_user
    if @comment.save
      flash[:notice] = "Comment was succeffully created."
    else
      flash[:danger] = "You can add only one comment to this movie."
    end
    redirect_to movie_path(@movie)
  end

  def destroy
    @comment = @movie.comments.find(params[:id])
    redirect_to movie_path(@movie) if @comment.user != current_user
    flash[:notice] = "Comment was succeffully deleted." if @comment.destroy
    redirect_to movie_path(@movie)
  end

  private

  def comment_params
    params.fetch(:comment, {}).permit(:user_id, :content)
  end

  def set_movie
    @movie = Movie.find(params[:movie_id])
  end
end
