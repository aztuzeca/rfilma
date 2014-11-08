rfilma
======

Libreria para recoger datos de Filmaffinity. Los registros capturados se almacenarán en una base de datos Mongo.
La estructura será:

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

Para ejecutar el crawler

    bundle install
    bundle exec rake crawler

Se incluye un volcado de la BD en JSON (data.bz2)