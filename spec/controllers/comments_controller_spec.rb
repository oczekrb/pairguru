require "rails_helper"

RSpec.describe CommentsController, type: :controller do
  let(:movie) { FactoryBot.create :movie }
  let(:user) { FactoryBot.create :user, email: "user1@example.com" }

  describe "POST #create" do
    it "creates requested comment" do
      sign_in user
      expect do
        post :create, params: { movie_id: movie.id, comment: { content: "content" } }
      end.to change(Comment, :count).by(1)
      expect(Comment.first.content).to eql("content")
      expect(response).to redirect_to(movie_path(movie))
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested admin" do
      comment = Comment.create user: user, content: "content", movie: movie
      sign_in user
      expect do
        delete :destroy, params: { movie_id: movie.id, id: comment.id }
      end.to change(Comment, :count).by(-1)
    end
  end
end
