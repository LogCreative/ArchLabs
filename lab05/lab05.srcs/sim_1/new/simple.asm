nop
lw  $3, 2($8)            # $8 serves as zero register
nop                      # jump here
lw  $0, 0($8)
lw  $1, 1($8)
sub $2, $0, $1
and $2, $0, $1
slt $2, $0, $1
or  $2, $0, $1
addi $2, $0, 8
andi $2, $0, -1
ori  $2, $0, -1
add $2, $0, $1          # final save: += 1
sw  $2, 0($8)
beq $2, $3, 1
jal 2
nop