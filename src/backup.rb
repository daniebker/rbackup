require 'socket'
require 'fileutils'
require 'pathname'

require_relative 'ZipFileGenerator'

Zip.setup do |c|
    c.default_compression = Zlib::BEST_COMPRESSION
end

target = "J:/Back Up/"
directoryToZip = Pathname.new("C:/Users/dbaker/Dropbox/Photos")
outputDir = Pathname.new(target + Socket.gethostname + "/" + directoryToZip.to_s().tr(':', ''))
FileUtils.mkpath(outputDir.parent.to_s)
outputFile =  outputDir.to_s + "_" + Time.now.strftime("%Y%m%d%H%M%S") + ".zip"
zf = ZipFileGenerator.new(directoryToZip, outputFile)
zf.write()