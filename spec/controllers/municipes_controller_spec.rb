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

  describe 'GET #new' do
    it 'assigns a new Municipe to @municipe' do
      get :new
      expect(assigns(:municipe)).to be_a_new(Municipe)
    end

    it 'renders the new template' do
      get :new
      expect(response).to render_template('new')
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      let(:valid_attributes) { attributes_for(:municipe) }

      it 'creates a new Municipe' do
        expect {
          post :create, params: { municipe: valid_attributes }
        }.to change(Municipe, :count).by(1)
      end

      it 'redirects to the municipes path with a notice' do
        post :create, params: { municipe: valid_attributes }
        expect(response).to redirect_to(municipes_path)
        expect(flash[:notice]).to eq('Municipe was successfully created.')
      end
    end

    context 'with invalid parameters' do
      let(:invalid_attributes) { attributes_for(:municipe, full_name: nil) }  # Assuming full_name is required

      it 'does not create a new Municipe' do
        expect {
          post :create, params: { municipe: invalid_attributes }
        }.not_to change(Municipe, :count)
      end

      it 're-renders the new template' do
        post :create, params: { municipe: invalid_attributes }
        expect(response).to render_template('new')
      end
    end
  end
end
