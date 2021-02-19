require "./spec_helper"

describe Jinx::Build do
  it "Build.new()" do
    expect_raises(Exception, /in\/ is not a dir/) { 
      Jinx::Build.new(input: "in/") 
    }

    build_2 = Jinx::Build.new(
      input: File.join(__DIR__, "repo"))

    build_1 = Jinx::Build.new(
      input: File.join(__DIR__, "repo"), 
      output: Dir.tempdir)

    build_2.execute()

    pp build_2

    build_2.manifest.available.size.should eq 5
    noop = build_2.manifest.available.find {|asset|
      asset.file.includes?("noop.lic")
    }
    fail "noop.lic did not compile" unless noop
    noop.tags.size.should eq 3
    noop.type.should eq "script"
    noop.last_commit.should_not be_nil

    xml_file = build_2.manifest.available.find {|asset|
      asset.file.includes?("empty.xml")
    }
    fail "empty.xml did not compile" unless xml_file
    xml_file.tags.should be_empty
    xml_file.type.should eq "data"
    xml_file.last_commit.should_not be_nil

    map_image = build_2.manifest.available.find {|asset|
      asset.file.includes?("circle.png")
    }
    fail "circle.png map image did not compile" unless map_image
    map_image.tags.should be_empty
    map_image.type.should eq "map"
    map_image.last_commit.should_not be_nil

    lich_file = build_2.manifest.available.find {|asset|
      asset.file.includes?("lich.rb")
    }
    fail "lich.rb did not compile" unless lich_file
    lich_file.tags.should be_empty
    lich_file.type.should eq "engine"
    lich_file.last_commit.should_not be_nil
  end
end

