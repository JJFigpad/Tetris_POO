<p align="right"><img src="https://seeklogo.com/images/U/Universidad_Nacional_de_Colombia_-_Sede_Bogot_and__225_-logo-A05EAD6D0F-seeklogo.com.png" width="30%"></p>

# Tetris_POO
**Nombre:** Juan José Figueroa

**Fecha de publicación:** 8 de octubre de 2020

## Índice

1. [Introducción](#introducción)
2. [Objetivo](#objetivo)
3. [Representación de los tetrominos](#representación)
4. [Representación del tablero y función `glue`](#representación)
5. [Conclusiones](#conclusiones)
6. [Referencias](#referencias)

## Introducción
Como segunda entrega del curso de Programación Orientada a Objetos, este proyecto es una versión del juego Tetris en el lenguaje de Processing (JAVA) bajo 
el paradigma de la Programación Orientada a Objetos.

## Objetivo
Recrear el juego del Tetris utilizando el paradigma de la Programación Orientada a Objetos y la plantilla dada por el profesor (modificada a necesidad), corregir 
los errores presentes en la primera entrega, añadir la mecánica de pausa, de cambio de ficha y de una pantalla inicial al juego, y llegar a una conclusión sobre 
el uso del paradigma ya mencionado al comparar este proyecto con el anterior.

## Representación de los tetrominos
En este proyecto se encuentra una única clase: la clase `Tetromino`. Dicha clase consta de los atributos `shape` y `c`, y los métodos `get()`, `set()`, `rotate()`, `displaytoP()`, `displayP()` y `update()`.
###### Atributos
- **Shape:** el cual es un arreglo bidimensional del tipo de dato `byte`, el cual vamos a ver como una matriz cuadrada 3x3 o 4x4 según el tetromino a ser 
representado.
- **c:** es un arreglo unidimensional de tamaño 3, el cual contiene tres enteros escogidos al azar entre 0 y 255. Este atributo es el encargado de darle el color al tetromino.
###### Métodos
- **get y set**: estos métodos son los encargados de leer y asignar los valores a la matriz cuadrada `shape`, la cual es la base del dibujo de los tetrominos 
y sus propiedades. Para más información sobre el uso y el funcionamiento de estos métodos revisar la referencia (3).
- **rotate():** este método es el encargado de la rotación del tetromino en juego. Funciona rotando los valores de la matriz cuadrara `shape` en sentido horario.
- **displaytoP():** este método es el encargado de dibujar sobre el tablero y a traves del cual surten efecto los desplazamientos horizonatales y verticales del tetromino en juego.
- **displayP():** este método es el encargado de dibujar el tetromino en la posición de siguiente.
- **update():** este método retorna un arreglo bidimensional en el cual se encuentran las posición en 'x' y 'y' iniciales de todas las componentes del tetromino con respecto al tablero.

## Representación del tablero y función `glue`
El tablero es una arreglo bidimensional que lo veremos como una matriz 20x10 de ceros, el cual tiene su dibujo inicial, la representación de los tetrominos caidos y la propiedad de eliminación de fila en la función `drawTablero()`. Pero la función que hace posible una conexión entre el tetromino en juego y el tablero es la
función `glue`:
- **glue(int[][] p):** esta función recibe como parámetro un arreglo bidimensional, el cual va a estar dado por el método `update()` de la clase
`Tetromino`.
Gracias a lo que este método retorna, esta función utiliza la posisición del tetromino y su desplazamiento sobre el tablero para verificar las colisiones con los limites del tablero, los cuales son manejados a través del manejo de excepciones, las colisiones con casillas ocupadas, las cuales son tetrominos caidos representados por casillas de valor 1, el fin del recorrido de un tetromino, su representacion en tablero como casillas llenas y la continuación del juego.

## Conclusiones
Al comparar el anterior proyecto con este, el punto más notorio deberia ser la extensión de los mismos. Mientras en el primero proyecto se superaron las mil líneas de código, en este segundo se lograron llevar a cabo más cosas en una menor cantidad de líneas, lo cual es un gran avance tanto en el proceso de abstracción de los problemas como en la toma de decisiones sobre el camino que va a seguir el proyecto. También se asegura que solo se vea afectado el objeto con los procesos con los que se desea afectarlo, sin efectos colaterales sobre el mismo o sobre el resto del código.

Pero también se ha de decir que para la practicidad de este paradigma de programación es necesario que los objetos compartan la mayoria de de atributos, puesto que en caso contrario la generación de muchas clases vuelve confuso y engorroso su uso, e incluso se vuelve algo innecesario usar este paradigma.

Una futura implementación sería un Tetris 3D, donde la eliminación de fila se da al completar una linea de la base de un cubo.
## Referencias
1. Jean Pierre Charalambos - Plantilla base https://github.com/objetos/p5.polyomino.js
2. http://www.bowdoin.edu/~echown/courses/210/javalab9/TetrisAssignment.pdf
3. get and set - https://www.w3schools.com/java/java_encapsulation.asp
4. Processing API - https://processing.org/reference/
5. https://github.com/younesyu/one_night_tetris
6. https://forum.processing.org/two/discussion/24334/i-m-trying-to-make-a-simple-tetris-game-but-i-can-t-figure-out-how-to-make-the-shapes-act-as-one
