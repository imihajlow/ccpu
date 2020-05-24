#!/bin/bash

make $1.bin && ../tools/sim.py $1.bin $1.map -c 'b trap' -c 'b fail' -c 'w __seg_stack_begin' -c 'r'
