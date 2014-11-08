require_relative "pelicula"
require_relative "crawler"

class CrawlerDB < Crawler 

	def initialize
		super
	end

	def obtener_pelicula(id)
		Pelicula.where(id: id).as_json
	end

	def buscar_por_titulo(titulo)
		Pelicula.where(titulo: /#{titulo}/i).as_json
	end

	def guardar_pelicula(id)		
		p = Crawler.new.obtener_pelicula(id)		
		m = Pelicula.new(p)
		m.upsert
	end

	def guardar_peliculas(ids,nthread=5)
		pool = Thread.pool(nthread)	
		ids2 = Pelicula.find(ids).each.map{|idd| idd["id"]}
		ids3 = (ids - ids2) + (ids2 - ids)	
		ids3.each{|i|
			pool.process{
				guardar_pelicula(i)				
			}
		}
		pool.shutdown
	end

	def procesar_paginas(letra)
		pagina = 1
		# Cualquier categoría tiene más de una página
		r = ">>"		
		indices_pelis = []
		while r.include?(">>")
			p = @a.get("http://www.filmaffinity.com/es/allfilms_#{letra}_#{pagina}.html").body
			doc = Nokogiri::HTML(p)
			r = doc.xpath('//div[@class="pager"]/a[contains(text(),">>")]').text
			doc.xpath('//div[@class="movie-card movie-card-1"]').each{|mc|
				indices_pelis << mc["data-movie-id"].to_i
			}
			pagina+=1
		end
		# Evitamos indices duplicados
		Set.new(indices_pelis).to_a
	end

	def procesar_todo
		cat = ('A'..'Z').to_a << "*" << "0-9"
		pool = Thread.pool(5)
		cat.each{|c|
			pool.process{
				ra = procesar_paginas(c)
				guardar_peliculas(ra)
			}
		}
		pool.shutdown
	end
end

