# Useful commands and stuff/knowledge

## Registers: 

# Predefined Purposes of Registers in x86 Assembly

### 1. General-purpose Registers
- **AX (Accumulator Register)**: Used for arithmetic, I/O, and data movement.
- **BX (Base Register)**: Often used as an address pointer for memory operations.
- **CX (Count Register)**: Used for loop counters or string operations.
- **DX (Data Register)**: Used for I/O operations or extended arithmetic.

### 2. Segment Registers
- **CS (Code Segment)**: Holds the segment address of the program code.
- **DS (Data Segment)**: Points to data used by the program.
- **SS (Stack Segment)**: Points to the stack.
- **ES, FS, GS**: Additional segments for special purposes.

### 3. Instruction-related Registers
- **IP (Instruction Pointer)**: Points to the next instruction.
- **Flags Register (EFLAGS)**: Stores condition flags (e.g., Zero Flag, Carry Flag).

### 4. Pointer and Index Registers
- **SP (Stack Pointer)**: Points to the top of the stack.
- **BP (Base Pointer)**: Used for stack frame referencing.
- **SI (Source Index)**: Used in string operations.
- **DI (Destination Index)**: Used in string operations.
