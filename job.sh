#!/bin/bash

# Comandos de execução do seu programa:

for TEMP in 1.6 1.7 1.8 1.9 2.0 2.1 2.2 2.3 2.4 2.5 2.6 2.7 2.8 2.9
do
        for i in {1..100}
        do
           ./a.out $TEMP
        done
done


