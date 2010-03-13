spec = Gem::Specification.new do |s|
  s.name = 'cellgrid'
  s.version = '0.0.7'
  s.summary = "Grid system for use in games."
  s.description = "A robust grid and cell structure for use in games with discrete maps, such as rogue-likes."
  s.files = Dir['lib/**/*.rb'] + Dir['test/**/*.rb'] + ['Rakefile.rb']
  s.author = "Adam Gardner"
  s.email = "adam.oddfellow@gmail.com"
  s.homepage = "http://bitbucket.org/philomory/cellgrid/"
end