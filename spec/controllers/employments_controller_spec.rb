require 'rails_helper'

RSpec.describe EmploymentsController, type: :controller do
  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to have_http_status(200)
    end
  end

  describe "GET #show" do
    it "responds successfully if employment exists in DB" do
      e1 = create(:employment)

      get :show, params: { id: e1.id }
      expect(response).to have_http_status(200)
    end
  end

  describe "DELETE #destroy_all" do
    it "Should flush entire DB and redirect to index with HTTP 302 status code" do
      delete :destroy_all
      expect(response).to have_http_status(302)
    end
  end
end
