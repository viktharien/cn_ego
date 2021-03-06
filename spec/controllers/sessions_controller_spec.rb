require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  let(:user) {create(:user)}
  let(:params) {params = {session: {email: user.email, password: user.password}}}
  let(:invalid_params) {params = {session: {email: user.email, password: "not correct"}}}
  describe "GET #new session" do
    it "returns a 200 http status of success" do
      get :new
      expect(response).to have_http_status(:success)
    end

  end

  describe "POST #create session" do

    it "creates a new session" do
      post :create, params: params
      expect(controller.session[:user_id]).to_not be_nil
    end

    it "renders a flash message on new session" do
      post :create, params: params
      expect(flash[:notice]).to be_present
    end

    it "redirects to participants_path on new session" do
      post :create, params: params
      expect(response).to redirect_to(participants_path)
    end

    it "fails to create new session with invalid credentials" do
      post :create, params: invalid_params
      expect(controller.session[:user_id]).to be_nil
    end

    it "renders a flash message on failure to create new session" do
      post :create, params: invalid_params
      expect(flash[:alert]).to be_present
    end

    it "renders new template on failure to create new session" do
      post :create, params: invalid_params
      expect(response).to render_template :new
    end
  end

  describe "DELETE #destroy session" do
    it "sets session user_id to nil" do
      post :create, params: params
      delete :destroy
      expect(controller.session[:user_id]).to be_nil
    end

    it "renders flash message on destroy" do
      post :create, params: params
      delete :destroy
      expect(flash[:notice]).to be_present
    end

    it "redirects to root on destroy" do
      post :create, params: params
      delete :destroy
      expect(response).to redirect_to(root_path)
    end
  end
end