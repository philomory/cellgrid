spec = Gem::Specification.new do |s|
  s.name = 'cellgrid'
  s.version = '0.0.1'
  s.summary = "Grid system for use in games."
  s.description = "A robust grid and cell structure for use in games with discrete maps, such as rogue-likes."
  s.files = Dir['lib/**/*.rb'] + Dir['test/**/*.rb'] + ['Rakefile.rb']
end