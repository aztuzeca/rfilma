$LOAD_PATH << File.join(File.dirname(__FILE__),"lib")
require_relative "lib/rfilma"

desc 'Lanzar Crawler'
task :crawler do
	puts "Guardando todas las películas de FilmAffinity"
	rfa = RFilma.new
	rfa.crawlerdb.procesar_todo
end
