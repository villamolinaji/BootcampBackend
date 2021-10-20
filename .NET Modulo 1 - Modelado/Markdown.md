## Bootcamp Backend - Laboratorio - .NET - Modulo 1 - Modelado

En primer lugar voy a explicar cada una de las tablas modelados y los detalles de cada una.

* Area
Esta tabla es para almacenar las distintas areas para categorizar un curso.
He incluido el campo AreaPadreId para incluir jerarquía, haciendo uso de la recursividad.

* Curso
Tabla para almacenar los distintos cursos.
La relación con la tabla Area es 1 a muchos, un curso tiene un area pero un area puede tener varios cursos.
Por lo que he incluido el campo AreaId en la tabla Curso y relacionarlo mediante foreign key.

* Autor
Tabla para gestionar los distintos autores

* Curso Autor
Tabla para relacionar un autor con un curso.
Esta tabla es necesaria, ya que un autor puede estar relacionado con varios autores, y a su vez, un curso estar relacionado con varios autores (muchos a muchos).

* Video
Tabla para almacenar la información de cada vídeo.
En esta tabla simplemente es necesario almacenar la URL del vídeo y el un campo foreign key para relacionar el autor del vídeo.
Relación uno a muchos, por lo que no es necesario una nueva tabla de asociación.

* Leccion
Tabla para gestionar las distintas lecciones de un curso, incluyendo relación al video asociado mediante foreign key (VideoId).
La relación con la tabla Curso es uno a muchos, por lo que es suficiente con incluir una foreign key (CursoId).
TextoURL almacenar la URL del texto.

* Tag
Tabla para almacenar los diferentes tags que se vayan creando.
Necesitamos de nuevas tablas para relacionar un tag con un curso o vídeo.

* TagCurso
Tabla de relación para asociar un curso con un tag.
Relación muchos a muchos.

* TagVideo
Tabla de relación para asociar un vídeo con un tag.
Relación muchos a muchos.

* Usuario
Almacena los distintos usuarios que se den de alta en el sistema.

* Subscripcion
Tabla para gestionar las distintas subscripciones disponibles.

* SubscripcionUsuario
Tabla para relacionar todas las subscripciones de un usuario (relación muchos a muchos).
Incluye un campo fecha para indicar la fecha de comienzo de subscripción.
Sería bueno tener otro campo para gestionar la fecha de caducidad de la subscripción, pero no la incluido al no estar indicado este requerimiento.

* SubscripcionVideo
No tenía claro si la subscripción es a un vídeo o a un curso y todos sus vídeos.
He optado por crear una tabla que relacione una subscripción con los vídeos a los que da acceso (relación muchos a muchos).

* Visualizacion
Tabla para auditar la visualización de cada uno de los vídeos.
El campos UsuarioId puede contener nulos, en caso de que la visualización se realice por usuarios no registrados.