require 'rake/testtask'

Rake::TestTask.new(:test) do |t|
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
  t.warning = true
end

desc "Run tests"
task :default => :test
