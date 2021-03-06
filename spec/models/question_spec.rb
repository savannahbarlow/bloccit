require 'rails_helper'

RSpec.describe Question, type: :model do
  let(:name) { RandomData.random_sentence }
  let(:description) { RandomData.random_paragraph }
  let(:title) { RandomData.random_sentence }
  let(:body) { RandomData.random_paragraph }
  let(:user) {User.create!(name: "Bloccit User", email: "user@bloccit.com", password: "helloworld")}
  let(:topic) { Topic.create!(name: name, description: description) }
  let(:post) { topic.posts.create!(title: title, body: body, user: user) }

  describe "attributes" do
    it "has title and body attributes" do
      expect(post).to have_attributes(title: title, body: body, user: user)
    end
  end
end
