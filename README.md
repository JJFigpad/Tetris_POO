<p align="center"><img src="https://seeklogo.com/images/U/Universidad_Nacional_de_Colombia_-_Sede_Bogot_and__225_-logo-A05EAD6D0F-seeklogo.com.png" width="100%"></p>

# Tetris_POO
**Nombre:** Juan José Figueroa

**Fecha de publicación:** 8 de octubre de 2020

## Índice

1. [Introducción](#introducción)
2. [Objetivo](#objetivo)
3. [Representación de los tetrominos](#representación)
4. [Representación del tablero y función `glue`](#representación)
5. [Referencias](#referencias)

## Introducción
Como segunda entrega del curso de Programación Orientada a Objetos, este proyecto es una versión del juego Tetris en el lenguaje de Processing (JAVA) bajo 
el paradigma de la Programación Orientada a Objetos.

## Objetivo
Recrear el juego del Tetris utilizando el paradigma de la Programación Orientada a Objetos y la plantilla dada por el profesor (modificada a necesidad), corregir 
los errores presentes en la primera entrega, añadir la mecanicá de pausa, de cambio de ficha y de una pantalla inicial al juego, y llegar a una conclusión sobre 
el uso del paradigma ya mencionado al comparar este proyecto con el anterior.

## Representación de los tetrominos
En este proyecto se encuentra una única clase: la clase Tetromino. Dicha clase consta de los atributos `shape` y `c`, y los métodos `get()`, `set()`, `rotate()`, 
`displaytoP()`, `displayP()` y `update()`.
###### Atributos
- **Shape:** el cual es un arreglo bidimensional del tipo de dato `byte`, el cual vamos a ver como una matriz cuadrada 3x3 o 4x4 según el tetromino a ser 
representado.
- **c:** es un arreglo unidimensional de tamaño 3, el cual contiene tres enteros escogidos al azar entre 0 y 255.
###### Métodos
- **get / set**: estos métodos son los encargados de leer y asignar los valores a la matriz cuadrada `shape`, la cual es la base del dibujo de los tetrominos 
y sus propiedades. Para más información sobre el uso y el funcionamiento de estos métodos revisar la referencia señanala (*).
- **rotate():** este método es el encargado de la rotación del tetromino en juego. Funciona rotando los valores de la matriz cuadrara `shape` en sentido horario.
- **displaytoP():** este método es el encargado de dibujar y a traves del cual surte efecto los desplazamientos horizonatales y verticales del tetromino en juego.
- **displayP():** este método es el encargado de dibujar el tetromino en la posición de siguiente.
- **update():** este método retorna un arreglo bidimensional en el cual se encuentran las posición en 'x' y 'y' con respecto al tabler de todas las componentes 
del tetromino.

## Representación del tablero y función `glue`
El tablero es una arreglo bidimensional que lo veremos como una matriz 20x10, el cual tiene su dibujo inicial, la representación de los tetrominos caidos y la
propiedad de eliminación de fila en la función `drawTablero()`. Pero la función que hace posible una conexión entre el tetromino en juego y el tablero es la
función `glue`:
- **glue(int[][] p):** esta función recibe como parámetro un arreglo bidimensional de ceros, el cual va a estar dado por el método `update()` de la clase
`Tetromino`.
Gracias a lo que este método retorna, esta función utiliza la posisición del tetromino sobre el tablero para verificar las colisiones con los limites del tablero,
los cuales son manejados a través de manejo de excepciones, las colisiones con casillas ocupadas, las cuales son casillas donde el valor de la matriz es 1, el fin
del recorrido de un tetromino, su representacion en tablero como casillas llenas y la continuación del juego.
