class FileMAnageController < ApplicationController
  def getFileContent
    @files = Dir.glob('*')
  end

end
