require "rails_helper"

RSpec.describe Comment, type: :model do
  let(:genre) { FactoryBot.create :genre }
  let(:movie) { FactoryBot.create :movie, genre: genre }
  let(:user) { FactoryBot.create :user }

  it { is_expected.to validate_presence_of(:user_id) }
  it { is_expected.to validate_presence_of(:movie_id) }
  it { is_expected.to validate_presence_of(:content) }

  it "uniqueness of comment with user_ud scoped to movie_id" do
    Comment.create user: user, movie: movie, content: "Some content"

    aggregate_failures "one user - two diffrent comments content" do
      comment = Comment.new user: user, movie: movie, content: "Diffrent content"
      expect(comment).not_to be_valid
    end

    aggregate_failures "two user- two same comments content" do
      user2 = FactoryBot.create :user, email: "user2@example.com"
      comment = Comment.new user: user2, movie: movie, content: "Some content"
      expect(comment).to be_valid
    end
  end
end
