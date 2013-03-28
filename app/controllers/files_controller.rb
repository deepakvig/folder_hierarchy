class FilesController < ApplicationController

  def index
    @current_dir, @files = [], []
    path = Rails.root.to_s+ DATAPATH
    @files = FileStructure.dir_details path, "/" 
  end

  def download
    localfile = params[:file]
    @ftps.get(get_download_path(params[:dir],localfile),localfile)
    flash[:alert] = "Successfully downloaded file #{localfile} to root directory!"
    redirect_to chdir_files_path(:dir => params[:dir])
  end

  def chdir
    if params[:dir]
      @current_dir = params[:dir].split("/").reject! { |d| d.empty? }
      path = Rails.root.to_s+ DATAPATH + params[:dir]
      @files = FileStructure.dir_details path, params[:dir]
      render :index
    else
      redirect_to root_url
    end
  end

  def upload
    if params[:file]
      uploaded_io = params[:file]
      path = Rails.root.to_s+DATAPATH+"/"+params[:current_dir]+"/"+uploaded_io.original_filename
      File.open(path, "wb") { |f| f.write(uploaded_io.read) }
    end
    #redirect_to chdir_files_path(:dir => params[:current_dir])
  end

  def makedir
    if params[:dir]
      path = Rails.root.to_s+ DATAPATH + "/" + params[:current_dir] + "/" + params[:dir]     
      @file = FileStructure.create_dir(path, params[:current_dir] + "/" + params[:dir]) 
    end
  end

end
