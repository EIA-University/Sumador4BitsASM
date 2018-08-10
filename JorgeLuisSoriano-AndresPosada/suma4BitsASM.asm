.include "./m328Pdef.inc"
Inicio:
ldi r16,0b00000001; Registro r16 para el primer número
ldi r17,0b00001111; Registro r17 para el segundo número
ldi r18,0b00000000; Registro r18 para almacenar el signo del número uno
ldi r19,0b00000000; Registro r19 para almacenar el signo del número dos

bst r16,4; Toma el signo del número uno y lo guarda en T
bld r18,0; Asigna el signo al registro r18 para almacenarlo
bst r17,4; Toma el signo del número dos y lo guarda en T
bld r19,0; Asigna el signo de T y lo almacena en el registro r18

bst r18,6; Toma el 0 de un registro de signo para eliminar el de los números 

bld r16,4; Asigna el 0 al número uno (registro  r16), elimina el signo
bld r17,4; Asigna el 0 al número dos (registro  r17), elimina el signo

cp r18,r19; Compara si los signos son iguales 
breq SumarNumeros; Como son IGUALES signos salta a la suma de los dos

cp r16,r17; Hace la comparación de los números para ver el menor
brlo RestarNumerosConR16Menor; Cuando el R16 es MENOR salta a la resta correspondiente

neg r17 ; Hace el complemento A2 del registro R17
rjmp SumarNumeros ; Salta a la suma de los registros cuando tienen signos iguales con el r17 complementado

SumarNumeros: ; Hace la suma con los números correspondientes
add r16,r17; Realiza la suma de r16 y r17, y la guarda en r16
bst r16,4; Guarda el bit Num 5 en T que es el carry
bld r16,5; Asigna el carry al bit Num 6 para imprimirlo al r16
bst r18,0; Guarda el bit Num 1 del registro r18 que es el signo de la suma cuando son iguales
bld r16,4; Asigna el signo al bit Num 5 del r16 para imprimirlo
rjmp Fin; Salta a la muestra en los leds

RestarNumerosConR16Menor: ; Cuando hay números diferentes hace una resta con complemento A2
neg r16; Hace el complemento A2 para el número uno (registro r16)
add r16,r17; Hace la suma de los números y lo almacena en el registro r16
bst r19,0; Toma el signo del número dos (Mayor) y lo deja en T
bld r16,4; Asigna el signo de T al registro r16
rjmp Fin; Salta a la muestra en los leds

Fin:
out DDRB, r16 ;	Asigna el registro r16 como salida
out PortB,r16 ; Asigna el puerto B como salida con el registro r16
rjmp Fin
