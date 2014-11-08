require "mechanize"
require "set"
require "thread/pool"



class Crawler

	def initialize
		@a = Mechanize.new{|op|
			op.user_agent_alias = "Windows Mozilla"
			op.set_proxy("localhost",8888)
		}
	end


	def obtener_pelicula(id)
		data = {}
		page = @a.get("http://www.filmaffinity.com/es/film#{id}.html").body
		doc = Nokogiri::HTML(page)
		data["id"] = id
		data["titulo"] = doc.xpath("//h1[@id='main-title']/a/span").inner_html
		data["puntuacion"] = doc.xpath('//div[@id="movie-rat-avg"]').text.strip.gsub(",",".").to_f
		begin
			data["portada"] = doc.xpath('//div[@id="movie-main-image-container"]/a')[0]["href"]
		rescue
			data["portada"] = doc.xpath('//div[@id="movie-main-image-container"]/img')[0]["src"]
		end
		doc.xpath('//dl[@class="movie-info"]/dt').each{|m|
			dt = m.inner_html
			case 
			when dt.include?("Título original")
				data["titulo_original"] = m.next_element.text
			when dt.include?("Año")	
				data["año"] = m.next_element.text.to_i		
			when dt.include?("Duración")
				data["duracion"] = m.next_element.text.match('(\d*)')[1].to_i
			when dt.include?("País")
				data["pais"] = m.next_element.at('img')['title']
			when dt.include?("Director")		
				data["director"] = m.next_element.search('a').map{|e| e.inner_html.strip}
			when dt.include?("Guión")
				data["guion"] = m.next_element.text.split(",").map{|e|e.strip}
			when dt.include?("Música")
				data["musica"] = m.next_element.text.split(",").map{|e|e.strip}
			when dt.include?("Fotografía")
				data["fotografia"] = m.next_element.text.split(",").map{|e|e.strip}
			when dt.include?("Reparto")
				data["reparto"] = m.next_element.text.split(",").map{|e|e.strip}
			when dt.include?("Productora")
				data["productora"] = m.next_element.text
			when dt.include?("Género")		
				data["genero"] = m.next_element.search('a').map{|e| e.inner_html}
			when dt.include?("Web")	
				data["web"] = m.next_element.text
			when dt.include?("Sinopsis")	
				data["sinopsis"] = m.next_element.text			
			end
		}
		data
	end

	def buscar_por_titulo(titulo)
		indices_pelis = []
		p = @a.get("http://www.filmaffinity.com/es/search.php?stext=#{titulo.strip.gsub(" ","+")}&stype=title").body
		doc = Nokogiri::HTML(p)
		doc.xpath('//div[@class="movie-card movie-card-1"]').each{|mc|
			indices_pelis << mc["data-movie-id"].to_i
		}
		indices_pelis.map{|i| obtener_pelicula(i)}
	end
	
end