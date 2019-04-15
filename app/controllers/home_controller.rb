class HomeController < ApplicationController
  def welcome; end

  def top_ten
    @top_ten = User.left_joins(:comments)
      .group(:id, :create_at)
      .order("COUNT(comments.id) DESC")
      .where("comments.created_at > ?", 7.days.ago)
      .limit(10)
  end
end
