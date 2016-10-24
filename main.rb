require 'socket'
require 'fileutils'
require 'pathname'

require_relative 'ZipFileGenerator'

Zip.setup do |c|
    c.default_compression = Zlib::BEST_COMPRESSION
end

source = ARGV[0]
target = ARGV[1]

directoryToZip = Pathname.new(source)
outputDir = Pathname.new(target + Socket.gethostname + "/" + directoryToZip.to_s().tr(':', ''))
FileUtils.mkpath(outputDir.parent.to_s)
outputFile =  outputDir.to_s + "_" + Time.now.strftime("%Y%m%d%H%M%S") + ".zip"
zf = ZipFileGenerator.new(directoryToZip, outputFile)
zf.write()