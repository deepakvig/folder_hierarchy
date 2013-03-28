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

  describe 'GET #chdir' do
    it "renders the :index view if params[:dir] is present" do
      FileStructure.stub(:dir_details) { [] }
      get :chdir, dir: 'data'
      expect(response).to render_template :index
    end

    it "redirects to homepage if params[:dir] is not present" do
      get :chdir
      expect(response).to redirect_to root_url
    end
  end

  describe 'POST #upload' do
    it "uploads the file" do
      File.stub(:open){true}
      true.stub(:set_encoding)
      file = fixture_file_upload('/files/upload.json','application/json')
      post :upload, file: file, current_dir: 'path'
      expect(response).to redirect_to chdir_files_path(dir: '/path')
    end
  end

  describe 'POST #makedir' do
    it "creates a new directory" do
      FileStructure.stub(:create_dir) { ['file'] }
      post :makedir, dir: 'directory', current_dir: 'path', format: :js
      expect(assigns(:file)).not_to be_nil
    end
  end
end
