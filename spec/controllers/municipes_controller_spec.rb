require 'rails_helper'

RSpec.describe MunicipesController, type: :controller do
  render_views

  describe "GET #index" do
    context "when no search term is provided" do
      it "assigns all municipes to @municipes" do
        municipe = create(:municipe)
        get :index
        expect(response.body).to include(municipe.full_name)
      end

      it "renders the index template" do
        get :index
        expect(response).to have_http_status(:ok)
      end
    end

    context "when a search term is provided" do
      it "assigns the matching municipes to @municipes" do
        matching_municipe = create(:municipe, full_name: "John Doe")
        non_matching_municipe = create(:municipe, full_name: "Jane Doe")
        get :index, params: { search: "John" }
        expect(response.body).to include(matching_municipe.full_name)
        expect(response.body).not_to include(non_matching_municipe.full_name)
      end

      it "renders the index template" do
        get :index, params: { search: "John" }
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
