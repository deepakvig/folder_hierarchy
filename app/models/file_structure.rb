
require 'filemagic'

class FileStructure
  # attr_accessible :title, :body

  def self.dir_details path, rel_path
    files = []
    Dir.new(path).each do |f|
      next if f == '.' or f == '..'
      puts f
      file = {
               :name => f,
               :mdate => File.mtime(File.join(path,f)),
               :type => File.directory?(File.join(path,f)) ? 'Folder' : FileMagic.mime.file(File.join(path,f)),
               :size => File.size(File.join(path,f)),
               :download => !File.directory?(File.join(path,f)), 
               :path => File.directory?(File.join(path,f)) ? File.join(rel_path,f) : File.join(DOWNLOADPATH, rel_path,f)
             }
      files << file
    end
    files
  end

  def self.create_dir path, rel_path
    Dir.mkdir File.join(path), 0755
    file = {
               :name => path.split('/').last,
               :mdate => Time.now,
               :type => 'Folder',
               :size => File.size(File.join(path)),
               :download => !File.directory?(File.join(path)),
               :path => File.join(rel_path)
             }
    file
  end
end
