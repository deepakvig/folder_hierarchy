class FilesController < ApplicationController

  def index
    @current_dir, @files = ["/"], []
    path = Rails.root.to_s+ DATAPATH
    @files = FileStructure.dir_details path
  end

  def download
    localfile = params[:file]
    @ftps.get(get_download_path(params[:dir],localfile),localfile)
    flash[:alert] = "Successfully downloaded file #{localfile} to root directory!"
    redirect_to chdir_files_path(:dir => params[:dir])
  end

  def chdir
    @ftps.chdir(get_directory_path(params[:prev_dir], params[:dir]))
    @dirs, @files = FtpManager.seg(@ftps.list)
    current_path = @ftps.pwd.reverse #.gsub!("/","")
    @prev_dir = current_path[current_path.index("/")+1..-1].reverse
    @current_dir = current_path.reverse
    render :index
  end

  def upload
    if params[:file]
      path = params[:current_dir] == "/" ? "" : params[:current_dir]
      @ftps.putbinaryfile(params[:file].path, remotefile = path+"/"+params[:file].original_filename)
      flash[:alert] = "File Uploaded Successfully"
    end
    redirect_to chdir_files_path(:dir => params[:current_dir])
  end

  def makedir
    if params[:dir]
      
    end
  end

end
