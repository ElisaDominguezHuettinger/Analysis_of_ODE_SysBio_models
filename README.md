# Analysis_of_ODE_SysBio_models
repository for pieces of code useful for analysing ode models of complex biological systems
Básicamente sólo necesitas modificar dos archivos:(1) el de tu modelo: necesitas crear una función que "coma" los parámetros cuya sensibilidad vas a variar (vector x) y "escupa" la variable de estado de la que te interese obtener la sensibilidad (ej. tu vector de estado y a las t=5horas, tu vector de estado estacionario, el pico máximo.. etc.). Si es una ODE entonces en ese archivo debes meterle la ecuación Y el integrador, para que te saque la solución que deseas en función de parámetros. Te muestro uno con un ejemplo sencillo de un modelo de 1D  "mymodel_hoefer".(2) un archivo para hacer el análisis de sensibilidad; esa función llama a tu modelo (en este caso, a mymodel_hoefer).. ahí especificas los valores nominales de parámetros, los rangos de variación, y el número de iteraciones... también te anexo el del modelo descrito en (1)

te anexo también un tutorial para este toolbox.
 
como siempre, recuerda fijarte que estés en el mismo directorio de trabajo que los archivos de GSAT.
saludosElisa
