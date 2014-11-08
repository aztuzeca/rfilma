require "mongoid"

mongoidyml = File.join(File.dirname(__FILE__),"..","config","mongoid.yml")
Mongoid.load!(mongoidyml,:production)

class Pelicula

	include Mongoid::Document

	field :id, type: Integer
	field :titulo, type: String
	field :titulo_original, type: String
	field :año, type: Integer
	field :duracion, type: Integer
	field :pais, type: String
	field :director, type: Array 
	field :guion, type: Array 
	field :musica, type: Array 
	field :fotografia, type: Array 
	field :reparto, type: Array 
	field :productora, type: String 
	field :genero, type: Array 
	field :sinopsis, type: String
	field :puntuacion, type: Float
	field :web, type: String
	field :portada, type: String	
	field :_id, type: Integer, overwrite: true, default: ->{ id }
end