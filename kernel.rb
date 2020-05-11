# Add method to require_all directory
module Kernel
  def require_all(directory_name)
    raise "Directory doesn't exist!" unless Dir.exist?(directory_name)

    dirs, files = files_by_type(directory_name)
    dirs.each { |dir| require_all(dir) }
    files.each { |file| require(file) }
  end

  protected

  def files_by_type(directory_name)
    directory_path = File.absolute_path(directory_name)
    Dir.new(directory_path)
       .reject { |name| name.start_with?('.') }
       .map { |name| File.expand_path(name, directory_path) }
       .partition { |file| File.directory?(file) }
  end
end
