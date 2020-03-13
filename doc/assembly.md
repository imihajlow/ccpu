# Programming model
## Registers

There are four 8-bit registers accessible to the user:
* A (8 bit) - accumulator
* B (8 bit) - alternative register
* P (16 bit) - pointer register, consisting on two halves:
  * PL (8 bit) - lower half
  * PH (8 bit) - upper half

The other registers are:
* IP - instruction pointer (16 bit)
* IR - instruction register (8 bit)
* Flags (4 bit) - ALU flags:
  * Z - zero
  * C - carry
  * S - sign
  * O - overflow

## Address space

The address space is flat 65536 bytes. Code and data occupy the same space.

# Instructions
## Load and store

Any register can be loaded with an immediate value (8 bit) using the `LDI` instruction.

Using the address from P any register can be loaded from (`LD A`) or stored to (`ST A`) memory.

Load and store instructions do not modify the flags.

## Arithmetics

There are 16 arithmetic instructions. Eight instructions take two operands:
* `ADD` - addition.
* `ADC` - addition with carry.
* `SUB` - subtraction.
* `SBB` - subtraction with borrow (indicated by C).
* `MOV` - copy.
* `AND` - bitwise AND.
* `OR`- bitwise OR.
* `XOR` - bitwise exclusive OR.

These instructions must take A (accumulator) as either of the operands. Both operands can't be the same register. If the destination register is A, 0 is allowed as source. In this case the operation is performed between A and zero.

Eight instructions take one operand:
* `INC` - increment.
* `DEC` - decrement.
* `SHL` - left shift by 1. The most significant bit is shifted into C.
* `NEG` - negation.
* `NOT` - bitwise inversion.
* `EXP` - expand C onto all bits.
* `SHR` - right shift by 1, zero extend. The least significant bit is shifted into C.
* `SAR` - right shift by 1, sign extend. The least significant bit is shifted into C.

All arithmetics instructions (excluding `MOV`) set the flags accordingly.

## Jumps

Jumps are performed by swapping IP and P. After a jump, P holds the address of the instruction following the jump.

The unconditional jump has the opcode `JMP`. There are eight conditional jump instructions (two for each flag):
* `JZ`
* `JC`
* `JS`
* `JO`
* `JNZ`
* `JNC`
* `JNS`
* `JNO`

Jump instructions do not modify the flags. If the condition for a conditional jump was not fulfilled, P is not modified.

## No operation (NOP)

There is no dedicated NOP instruction. Pure no operation is not possible. The maximum which can be achieved is an instruction which changes the flags, but not the register values, for example `ADD A, 0`

# Assembly language

There are few assembly directives:
* `.init` - begin the initialized section.
* `.noinit` - begin the uninitialized section. These two directives are useful in ROM file generation which has some labels in an uninitialized RAM space.
* `.offset X` - set the current code address.
* `.align X` - align the address by X.

There are two pseudo-functions, `lo(x)` and `hi(x)`, which take first and second bytes of `x`.

`db`, `dw`, `dd`, and `dq` pseudo-instructions output 1, 2, 4 and 8 bytes of data.

Python expressions are allowed for any numeric constants.
