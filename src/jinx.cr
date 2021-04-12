require "./header_parser"
require "./manifest"
require "./build"
# TODO: Write documentation for `Jinx`
module Jinx
  VERSION = "0.3.1"

  def self.build(input : String, output : String)
    Build.new(input:  File.join(Dir.current, input),
              output: File.join(Dir.current, output))
         .execute()
  end
end
