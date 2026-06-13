// ALU operation codes
`define ALU_ADD   4'b0000   // add                      : add, addi, lw, sw
`define ALU_SUB   4'b0001   // subtract                 : sub, beq, bne
`define ALU_AND   4'b0010   // bitwise AND              : and, andi
`define ALU_OR    4'b0011   // bitwise OR               : or,  ori
`define ALU_XOR   4'b0100   // bitwise XOR              : xor, xori
`define ALU_NOR   4'b0101   // bitwise NOR              : nor
`define ALU_SLT   4'b0110   // set less than (signed)   : slt
`define ALU_SLTU  4'b0111   // set less than (unsigned) : sltu
`define ALU_SLL   4'b1000   // shift left  logical      : sll
`define ALU_SRL   4'b1001   // shift right logical      : srl
`define ALU_SRA   4'b1010   // shift right arithmetic   : sra
`define ALU_LUI   4'b1011   // load upper imm           : lui

// Instruction opcodes
`define OP_RTYPE    6'b000000   // R-type: add, sub, and, or, slt, etc.
`define OP_ADDI     6'b001000   // addi    $rt, $rs, imm
`define OP_ADDIU    6'b001001   // addiu   $rt, $rs, imm (unsigned)
`define OP_ANDI     6'b001100   // andi    $rt, $rs, imm
`define OP_ORI      6'b001101   // ori     $rt, $rs, imm
`define OP_XORI     6'b001110   // xori    $rt, $rs, imm
`define OP_LUI      6'b001111   // lui     $rt, imm
`define OP_LW       6'b100011   // lw      $rt, offset($rs)
`define OP_SW       6'b101011   // sw      $rt, offset($rs)
`define OP_BEQ      6'b000100   // beq     $rs, $rt, offset
`define OP_BNE      6'b000101   // bne     $rs, $rt, offset
`define OP_BLEZ     6'b000110   // blez    $rs, offset
`define OP_BGTZ     6'b000111   // bgtz    $rs, offset
`define OP_J        6'b000010   // j       target

// Funct codes for R Type
`define FUNCT_ADD   6'b100000   // add
`define FUNCT_ADDU  6'b100001   // addu (unsigned)
`define FUNCT_SUB   6'b100010   // sub
`define FUNCT_SUBU  6'b100011   // subu (unsigned)
`define FUNCT_AND   6'b100100   // and
`define FUNCT_OR    6'b100101   // or
`define FUNCT_XOR   6'b100110   // xor
`define FUNCT_NOR   6'b100111   // nor
`define FUNCT_SLT   6'b101010   // slt  (signed)
`define FUNCT_SLTU  6'b101011   // sltu (unsigned)
`define FUNCT_SLL   6'b000000   // sll  (shift left logical)
`define FUNCT_SRL   6'b000010   // srl  (shift right logical)
`define FUNCT_SRA   6'b000011   // sra  (shift right arithmetic)
`define FUNCT_JR    6'b001000   // jr   (jump register)