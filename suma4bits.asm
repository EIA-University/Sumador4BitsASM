.include "./m328Pdef.inc"

main:

ldi r16,0b00011111; primer número
ldi r17,0b00001000; segundo número
ldi r18,0b00000000; registro pal signo de r16
ldi r19,0b00000000; registro pal signo de r17

bst r16,4; coge el cuarto bit de r16, que es el signo del primer numero 
bld r18,0; asigna ese número que cogió, al primer bit de r18
bst r17,4; coge el cuarto bit de r17, que es el signo del segundo numero
bld r19,0; asigna ese número que cogió, al primer bit de r19

bst r16,6; coge el sexto bit de r16, para colocar los dos numeros en positivo 
bld r16,4; asigna ese número al bit 4 del registro 16
bld r17,4; "" 17

cp r18,r19; compara signos
breq Sumar; sigue este camino si son iguales
cp r16,r17; compara estos dos registros para ver si r16 es menor 
brlo Sumar2; sigue este camino si son diferentes, si r16 es menor que r17 
neg r17; niega r17 si no se cumplen los casos anteriores y hace un jump al método de sumar
rjmp Sumar


Sumar:
add r16,r17; suma los registros
bst r16,4; coge el bit 4 que es el acarreo
bld r16,5; lo asigna al bit 5
bst r18,0; coge el signo
bld r16,4; lo asigna al bit 4 de la suma
rjmp Fin


Sumar2:
neg r16; se niega el otro registom, se cambiaron de  signos para sumarlos como si fueran complementos A2
add r16,r17; se hace la suma
bst r19,0; coge el signo
bld r16,4; se le asigna al bit 4 de la suma
rjmp Fin


Fin:

out DDRB,r16; se define B como el puerto de salida
out PortB,r16

rjmp Fin
