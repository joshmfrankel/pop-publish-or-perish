guard :minitest, spring: "bin/rails test -v" do
  # with Minitest::Unit
  watch(%r{^test/(.*)\/?(.*)_test\.rb$}) # Moved _test for Rails 5
  watch(%r{^(lib|app)/(.*/)?([^/]+)\.rb$})     { |m| "test/#{m[2]}#{m[3]}_test.rb" }
  watch(%r{^test/test_helper\.rb$})      { 'test' }
end
