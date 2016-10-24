require 'socket'
require 'fileutils'
require 'pathname'

require_relative 'ZipFileGenerator'

Zip.setup do |c|
    c.default_compression = Zlib::BEST_COMPRESSION
end

def directory_exists?(directory)
  File.directory?(directory)
end

source = ARGV[0]
target = ARGV[1]

directoryToZip = Pathname.new(source)

if target.to_s == ''
    outputDir = Pathname.new(directoryToZip.to_s())
else     
    outputDir =  Pathname.new(File.join(target, Socket.gethostname, directoryToZip.to_s().tr(':', '')))
end

if(!directory_exists?(outputDir.parent.to_s))
    FileUtils.mkpath(outputDir.parent.to_s)
end

outputFile =  outputDir.to_s + "_" + Time.now.strftime("%Y%m%d%H%M%S") + ".zip"
zf = ZipFileGenerator.new(directoryToZip, outputFile)
zf.write()