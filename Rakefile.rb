require 'rake/testtask'

Rake::TestTask.new do |t|
  t.pattern = "test/*test.rb"
  t.verbose = true
end