require 'rails_helper'

RSpec.describe GramsController, type: :controller do
  describe "grams#index action" do
    it "should successfully show the page" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "grams#new action" do
    it "should require user to be signed in" do
      get :new
      expect(response).to redirect_to new_user_session_path
    end
    it "should successfully show the new form" do
      user= FactoryBot.create(:user)
      sign_in user
      
      get :new
      expect(response).to have_http_status(:success)
    end
  end


  describe "grams#create action" do
    it "should require user to be signed in" do
      post :create, params: { gram: { message: 'Hello!'} }
      expect(response).to redirect_to new_user_session_path
    end

    it "should successfully create a new gram in our database" do
      user = FactoryBot.create(:user)
      sign_in user
      
      post :create, params: { gram: 
        { message: 'Hello!' , 
          picture: fixture_file_upload("/picture.jpg", 'image/jpg')
        } 
      }
      expect(response).to redirect_to root_path

      gram = Gram.last
      expect(gram.message).to eq("Hello!")
      expect(gram.user).to eq(user)
    end

    it "should properly deal with validation errors" do
      user = FactoryBot.create(:user)
      sign_in user

      post :create, params: { gram: { message: '' } }
      expect(response).to have_http_status( :unprocessable_entity )
      expect(Gram.count).to eq Gram.count
    end
  end


  describe "grams#show action" do
    it "should successfully show the page if gram is found" do
      gram = FactoryBot.create(:gram)
      get :show,params: { id: gram.id}
      expect(response).to have_http_status(:success)
    end

    it "should return a 404 error if gram is not found" do
      get :show, params: { id: "NONE"}
      expect(response).to have_http_status(:not_found)
    end

  end

  describe "grams#edit action" do 
    it "should not allow unauthorised used to edit a gram" do
      gram = FactoryBot.create(:gram)
      get :edit, params: { id: gram.id }
      expect(response).to redirect_to new_user_session_path
    end

    it "should a not allow a user who did not create a gram to edit it" do
      gram = FactoryBot.create(:gram)
      user = FactoryBot.create(:user)
      sign_in user
      get :edit, params: { id: gram.id }
      expect(response).to have_http_status(:forbidden)
    end
    it "should successfully show the edit form if gram is found" do
      gram = FactoryBot.create(:gram)
      sign_in gram.user
      get :edit, params: { id: gram.id }
      expect(response).to have_http_status(:success)
    end

    it "should return a 404 a error if gram is not found" do
      get :show, params: { id: "NONE" }
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "grams#update action" do
    it "should not allow unauthorised used to update a gram" do
      gram = FactoryBot.create(:gram)
      patch :update, params: { id: gram.id }
      expect(response).to redirect_to new_user_session_path
    end

    it "shouldn't let users who didn't create the gram update it" do
      gram = FactoryBot.create(:gram)
      user = FactoryBot.create(:user)
      sign_in user
      patch :update, params: { id: gram.id, gram: { message: "Changed" } }
      expect(response).to have_http_status(:forbidden)      
    end

    it "should allow users to successfully update the grams" do
      gram= FactoryBot.create(:gram, message: "Initial value")
      sign_in gram.user
      patch :update, params: { id: gram.id, gram: { message: "Changed" } }
      expect(response).to redirect_to root_path

      gram.reload
      expect(gram.message).to eq "Changed"
    end

    it "should return a 404 a error if gram to be updated is not found" do
      user = FactoryBot.create(:user)
      sign_in user
      patch :update, params: { id: "RANDOM_ID", gram: { message: "Changed" } }
      expect(response).to have_http_status(:not_found)
    end

    it "should render an edit form with an http status of unprocessable_entity" do
      gram= FactoryBot.create(:gram, message: "Initial value")
      sign_in gram.user
      patch :update, params: { id: gram.id, gram: { message: "" } }
      expect(response).to have_http_status(:unprocessable_entity)

      gram.reload
      expect(gram.message).to eq "Initial value"

    end
  end

  describe "grams#destroy action" do
    it "should not allow unauthorised used to destroy a gram" do
      gram = FactoryBot.create(:gram)
      delete :destroy, params: { id: gram.id }
      expect(response).to redirect_to new_user_session_path
    end

    it "shouldn't let users who didn't create the gram update it" do
      gram = FactoryBot.create(:gram)
      user = FactoryBot.create(:user)
      sign_in user
      delete :destroy, params: { id: gram.id }
      expect(response).to have_http_status(:forbidden)      
    end

    it "should allow user to destroy a gram" do
      gram = FactoryBot.create(:gram)
      sign_in gram.user
      delete :destroy, params: { id: gram.id}
      expect(response).to redirect_to root_path

      gram = Gram.find_by_id(gram.id)
      expect(gram).to eq nil
    end

    it "should return a 404 error if we can not find the gram with the id specified" do
      user = FactoryBot.create(:user)
      sign_in user
      delete :destroy, params: { id: "RANDOM_ID" }
      expect(response).to have_http_status(:not_found)
    end
  end

end
