
desc "Loads and created Directory structure provides in directories.yml"
task :load_data => :environment do
  FileUtils.cp_r Rails.root.to_s+"/lib/assets/Data", Rails.root.to_s+"/public"
end
