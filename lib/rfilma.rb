require "rfilma/crawler"
require "rfilma/crawlerdb"
require "rfilma/pelicula"

class RFilma

	attr_accessor :crawler, :crawlerdb

	def initialize
		@crawler = Crawler.new
		@crawlerdb = CrawlerDB.new
	end

	def buscar_por_titulo(titulo,web=false)
		if web
			result = @crawler.buscar_por_titulo(titulo)
			result.each{|a| @crawlerdb.guardar_pelicula(pp a["id"])}
		else
			result = @crawlerdb.buscar_por_titulo(titulo)
		end
		return result
	end

	# Entrada: 1->(A-Z) 2->(0-9) 3->(*)
	def actualizar_por_letra(caracter)
		pelis = []
		if caracter.upcase.match(/([A-Z])/)
			pelis = @crawlerdb.procesar_paginas(caracter.upcase.match(/([A-Z])/)[1])
		elsif caracter.match(/([0-9])/)
			pelis = @crawlerdb.procesar_paginas("0-9")
		else
			pelis = @crawlerdb.procesar_paginas("*")
		end
		@crawlerdb.guardar_peliculas(pelis)
	end

	def actualizar_todo
		@crawlerdb.procesar_todo
	end


end