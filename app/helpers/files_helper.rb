module FilesHelper
  def folder_path(dir, current_dir)
    folder_path = current_dir.join + "/" + folder_path if current_dir.join != "/"
    folder_path
  end

end
