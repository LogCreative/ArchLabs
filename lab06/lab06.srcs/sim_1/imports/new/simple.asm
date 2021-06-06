nop
lw  $16, 2($0)            # $0 zero register
jal 4
nop
lw  $8, 0($0)
lw  $9, 1($0)
sub $10, $8, $9
and $10, $8, $9
slt $10, $8, $9
or  $10, $8, $9
addi $10, $8, 8
andi $10, $8, -1
ori  $10, $8, -1
sll $10, $8, 1
srl $10, $8, 1
add $10, $8, $9          # final save: += 1
sw  $10, 0($0)
beq $10, $16, 1
jr $31
j 16
nop
nop