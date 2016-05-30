require 'rails_helper'

RSpec.describe SponsoredPostsController, type: :controller do
  let(:my_topic) { Topic.create!(name:  RandomData.random_sentence, description: RandomData.random_paragraph) }
  let(:my_sponsoredpost) { my_topic.sponsored_posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, price: 99) }


  describe "GET #show" do
    it "returns http success" do
      get :show, topic_id: my_topic.id, id: my_sponsoredpost.id
      expect(response).to have_http_status(:success)
    end
    it "renders the #show view" do
      get :show, topic_id: my_topic.id, id: my_sponsoredpost.id
      expect(response).to render_template :show
    end
    it "assigns my_sponsoredpost to @sponsored_post" do
      get :show, topic_id: my_topic.id, id: my_sponsoredpost.id
      expect(assigns(:sponsored_post)).to eq(my_sponsoredpost)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new, topic_id: my_topic.id
      expect(response).to have_http_status(:success)
    end

    it "renders the #new view" do
      get :new, topic_id: my_topic.id
      expect(response).to render_template :new
    end

    it "instantiates @sponsored_post" do
      get :new, topic_id: my_topic.id
      expect(assigns(:sponsored_post)).not_to be_nil
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      get :edit, topic_id: my_topic.id, id: my_sponsoredpost.id
      expect(response).to have_http_status(:success)
    end
    it "renders the #edit view" do
      get :edit, topic_id: my_topic.id, id: my_sponsoredpost.id
      expect(response).to render_template :edit
    end
    it "assigns post to be updated to @post" do
      get :edit, topic_id: my_topic.id, id: my_sponsoredpost.id
      sponsored_post_instance = assigns(:sponsored_post)

      expect(sponsored_post_instance.id).to eq my_sponsoredpost.id
      expect(sponsored_post_instance.title).to eq my_sponsoredpost.title
      expect(sponsored_post_instance.body).to eq my_sponsoredpost.body
      expect(sponsored_post_instance.price).to eq my_sponsoredpost.price
    end
  end

  describe "SponsoredPost create" do
    it "increases the number of Sponsored Posts by 1" do
      expect{post :create, topic_id: my_topic.id, sponsored_post: {title: RandomData.random_sentence, body: RandomData.random_paragraph, price: 99}}.to change(SponsoredPost,:count).by(1)
    end

    it "assigns the new sponsored post to @sponsored_post" do
      post :create, topic_id: my_topic.id, sponsored_post: {title: RandomData.random_sentence, body: RandomData.random_paragraph, price: 99}
      expect(assigns(:sponsored_post)).to eq SponsoredPost.last
    end

    it "redirects to the new sponsored_post" do
      post :create, topic_id: my_topic.id, sponsored_post: {title: RandomData.random_sentence, body: RandomData.random_paragraph, price: 99}
      expect(response).to redirect_to [my_topic, SponsoredPost.last]
    end
  end

  describe "PUT Update" do
    it "updates post with expected attributes" do
      new_title = RandomData.random_sentence
      new_body = RandomData.random_paragraph
      new_price = 99

      put :update, topic_id: my_topic.id, id: my_sponsoredpost.id, sponsored_post: {title: new_title, body: new_body, price: 99}

      updated_sponsoredpost = assigns(:sponsored_post)
      expect(updated_sponsoredpost.id).to eq my_sponsoredpost.id
      expect(updated_sponsoredpost.title).to eq new_title
      expect(updated_sponsoredpost.body).to eq new_body
      expect(updated_sponsoredpost.price).to eq new_price
    end

    it "redirects to the updated post" do
      new_title = RandomData.random_sentence
      new_body = RandomData.random_paragraph
      new_price = 99

      put :update, topic_id: my_topic.id, id: my_sponsoredpost.id, sponsored_post: {title: new_title, body: new_body, price: 99}
      expect(response).to redirect_to [my_topic, my_sponsoredpost]
    end
  end

  describe "DELETE destroy" do
    it "deletes the post" do
      delete :destroy, topic_id: my_topic.id, id: my_sponsoredpost.id

      count = SponsoredPost.where({id: my_sponsoredpost.id}).size
      expect(count).to eq 0
    end

    it "redirects to topic show" do
      delete :destroy, topic_id: my_topic.id, id: my_sponsoredpost.id
      expect(response).to redirect_to my_topic
    end
  end
end
