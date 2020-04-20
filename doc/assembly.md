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

The `NOP` instruction has a binary opcode pattern of 111x11xx (0xFF is one of the possible opcodes). It works as a conditional jump with an always-false condition.

# Assembly language

There are few assembly directives:
* `.const name = value` - define a constant.
* `.global name` - declare a symbol global (imported).
* `.export name` - export a symbol to make it visible for `.global`.
* `.section name` - start a section. Currently linker supports three sections: `init` (internal use for code placed at the beginning), `text` (ROM contents) and `data` (RAM).
* `.align X` - align the address by X.

There are two pseudo-functions, `lo(x)` and `hi(x)`, which take first and second bytes of `x`.

`db`, `dw`, `dd`, and `dq` pseudo-instructions output 1, 2, 4 and 8 bytes of data.

`res` reserves n bytes and initializes them with zeroes.

`ascii` outputs an ascii string as a byte sequence. Use of characters above 7bit ASCII is not supported.

Python expressions are allowed for any numeric constants.
