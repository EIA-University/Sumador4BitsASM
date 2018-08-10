.include "./m328Pdef.inc"
;Alexis García Ramírez
;Daniel Lopez Gaviria
;Luis Felipe Montoya

Inicio:
ldi r16,0b00011111; Registro R16 número uno
ldi r17,0b00011011;	Registro R17 número dos
ldi r18,0b00000000; Almacenamiento del signo del número uno
ldi r19,0b00000000;	Almacenamiento del signo del número dos

bst r16,4; Se captura bit 4 y se envia a la Bandera T
bld r18,0; Se asigna valor de bandera T al registro 18 en el bit 0
bst r17,4; Se captura bit 4 y se envia a la Bandera T
bld r19,0; Se asigna valor de bandera T al registro 19 en el bit 0

bst r18,6; Se captura bit 6 y se envia a la Bandera T
bld r16,4; Se asigna valor de bandera T al registro 16 en el bit 4
bld r17,4; Se asigna valor de bandera T al registro 17 en el bit 4

cp r18,r19; Se comparan los signos que estan guardados en los registros 18 y 19
breq SumarDosRegistros; Si son iguales se va al SumarDosRegistros:
cp r16,r17;Se compara cual es el Registro con el mayor valor.
brlo RestarDosRegistros16Menor; Si el registro 16 es el menor salta a RestarDosRegistros16Menor, sino sigue la secuencia
neg r17 ; Complemento a 2 al registro 17
rjmp SumarDosRegistros

SumarDosRegistros:
add r16,r17; Se suman los dos registros
bst r16,4; Se captura bit 4 y se envia a la Bandera T
bld r16,5; Se asigna valor de bandera T a el bit 5 para llevar el acarreo
bst r18,0; Se captura bit 0 y se envia a la Bandera T , este contiene el signo
bld r16,4;  Se asigna valor de bandera T a el bit 4 (donde esta el signo)
rjmp Imprimir

RestarDosRegistros16Menor:
neg r16; Complemento a 2 al registro 16
add r16,r17; Se suman los dos registros ("restan")
bst r19,0; Se captura bit 0 y se envia a la Bandera T , este contiene el signo
bld r16,4; Se asigna valor de bandera T a el bit 4 (donde esta el signo)
rjmp Imprimir

Imprimir:
out DDRB, r16 ;Se Habilitan las salidas de DDRB de acuerdo al valor del registro 16
out PortB,r16 ;Se ponen los Puertos B en los altos y bajos de acuerdo con el valor del registro 16
rjmp Imprimir
