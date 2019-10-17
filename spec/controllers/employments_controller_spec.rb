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

  describe "POST #import" do
    before(:each) do
      # fixture_file_upload instead of fixture_file prevents file conversion to String
      hash_file = {}
      @uploaded_file = fixture_file_upload('files/archive.csv', 'text/csv')
      hash_file['csv'] = @uploaded_file

      post :import, params: { file: hash_file }
    end

    it "Should import CSV file and Create Employments" do
      expect(Employment.count).to eq(73)
    end

    it "Should redirect to index with HTTP 302 status code" do
      expect(response).to have_http_status(302)
    end
  end

  describe "PATCH #enrich" do
    before(:each) do
      @e1 = create(:employment)
    end

    it "Should enrich the right Employment" do
      patch :enrichment, params: { id: @e1 }
      expect(@e1.reload.enriched).to eq(true)
    end

    it "Should redirect to #show" do
      patch :enrichment, params: { id: @e1 }
      expect(response).to have_http_status(302)
    end
  end

  describe "DELETE #destroy_all" do
    it "Should flush entire DB" do
      2.times { create(:employment) }
      expect(Employment.count).to eq(2)

      delete :destroy_all
      expect(Employment.count).to eq(0)
      expect(response).to have_http_status(302)
    end
    it "Should redirect to index with HTTP 302 status code" do
      delete :destroy_all
      expect(response).to have_http_status(302)
    end
  end
end
