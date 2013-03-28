require 'spec_helper'

describe FilesController do

  describe 'GET #index' do
    it "populates an array of files" do
      get :index
      expect(assigns(:files)).not_to be_nil
    end

    it "renders the :index view" do
      get :index
      response.should render_template :index
      expect(response).to render_template :index
    end

  end

end
