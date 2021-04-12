require "admiral"
require "./jinx"

class Jinxp < Admiral::Command
  define_help description: "builds a jinx repository"
  define_version Jinx::VERSION

  define_flag input : String, short: i, required: true,
    description: "the directory all assets reside in to compile"

  define_flag output : String, short: o, default: "dist",
    description: "the directory to compiled the repository assets to"

  def run
    Jinx.build( input: flags.input,
               output: flags.output)
  end
end

Jinxp.run()
