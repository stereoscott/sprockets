require 'sprockets_test'

class TestEnvironment < Sprockets::TestCase
  def setup
    @env = Sprockets::Environment.new
    @env.paths << fixture_path('default')
  end

  test "working directory is the default root" do
    assert_equal Dir.pwd, @env.root
  end

  test "resolve in environment" do
    assert_equal fixture_path('default/gallery.js'),
      @env.resolve("gallery.js").path
  end

  test "missing file raises an exception" do
    assert_raises(Sprockets::FileNotFound) do
      @env.resolve("null")
    end
  end

  test "find concatenated asset in environment" do
    assert_equal "var Gallery = {};\n",
      @env["gallery.js"].to_s
  end

  test "find static asset in environment" do
    assert_equal "Hello world\n",
      @env["hello.txt"].to_s
  end

  test "missing asset returns nil" do
    assert_equal nil, @env["missing.js"]
  end
end
