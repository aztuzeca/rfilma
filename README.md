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

    rfilma = RFilma.new
    rfilma.actualizar_todo

La actualización de la Base de Datos se puede realizar también por letras, números o símbolos. Para actualizar se debe invocar al método

	rfilma.actualizar_por_letra(letra)

La variable letra puede ser cualquier caracter de la A a la Z, un dígito del 0 al 10, o bien el * (asterisco) para la actualización de películas que empiece por símbolos.

Se ha implementado la busqueda por título bien a través de nuestra Base de Datos MongoDB o directamente a la web. La invocación del método sería de la siguiente forma:

	rfilma.buscar_por_titulo(titulo)        -> Busqueda por defecto en MongoDB
	
	rfilma.buscar_por_titulo(titulo,true)   -> Busqueda directamente en la web. Si los ids de películas no se encuentra en nuestra base de datos, automáticamente se incorporarán para acelerar las futuras busquedas.

Se incluye un volcado de la BD en JSON (data.bz2)