require "digest/sha1"
require "json"
require "./header_parser"

module Jinx
  class Asset
    include JSON::Serializable

    property file        : String
    property type        : String
    property md5         : String
    property last_commit : Int32|Int64
    property header      : String?
    property tags        : Array(String)
    property version     : String?
    property author      : String?


    def initialize(build : Build, file : String)
      source       = File.read(file)
      @md5         = Digest::SHA1.base64digest(source)
      @last_commit = _fetch_last_commit(file)
      @file        = "/assets/%s" % File.basename(file)

      File.copy(file, File.join(build.assets, File.basename(file)))

      case File.extname(file)
      when ".lic", ".rb"
        @type    = "script"
        parser   = headers(build, file, source)
        @tags    = parser.tags
        @header  = parser.file
        @version = parser.version
        @author  = parser.author
      else
        @type    = "data"
        @tags = [] of String
      end
    end

    def headers(build : Build, file : String, source : String)
      HeaderParser.new(
        build:  build,
        file:   file,
        source: source)
    end

    def _fetch_last_commit(file)
      ts = `git log -1 --date=unix --format="%ad" -- #{file}`.strip
      ts.empty? ? Time.utc.to_unix : ts.to_i
    end
  end
end
