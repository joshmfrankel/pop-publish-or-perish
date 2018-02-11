guard :minitest, spring: "bin/rails test -v" do
  # with Minitest::Unit
  watch(%r{^test/(.*)\/?(.*)_test\.rb$}) # Moved _test for Rails 5
  watch(%r{^lib/(.*/)?([^/]+)\.rb$})     { |m| "test/#{m[1]}test_#{m[2]}.rb" }
  watch(%r{^test/test_helper\.rb$})      { 'test' }
end
