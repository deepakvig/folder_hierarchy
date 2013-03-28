class FileStructure
  # attr_accessible :title, :body

  def self.dir_details path
    files = []
    Dir.new(path).each do |f|
      next if f == '.' or f == '..'
      file = {
               :name => f,
               :mdate => File.mtime(File.join(path,f)),
               :type => File.directory?(File.join(path,f)) ? 'Folder' : Mime::Type.lookup_by_extension(f),
               :size => File.size(File.join(path,f)),
               :download => !File.directory?(File.join(path,f)) 
             }
      files << file
    end
    puts files.inspect
    files
  end
end
