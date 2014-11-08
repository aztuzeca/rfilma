require "mongoid"

Mongoid.load!("#{Dir.getwd}/lib/config/mongoid.yml",:production)

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
end