.section .data

  arr:
    .long 5, 6, 2, 4

  ALEN:
    .long 4

  str:
    .ascii "R \n"

.section .text

.global _start

_start:
  movl $0, %r15d              # CONST: r15d = 0
  movl ALEN(,%r15d, 4), %r14d # CONST: r14d = ALEN 

#Bubble Sort
STEP1:
  movl $0, %ebx               # ebx = swapped
STEP2:
  movl $0, %eax               # eax = i
STEP3:
  incl %eax                   # i++
  cmpl %r14d, %eax            # if (i >= ALEN) jump to STEP5
  jge  STEP5

  
STEP4:
  movl %eax, %r8d             # r8d = i
  
  movl arr(,%r8d, 4), %r9d    # r9d = arr[i]
  decl %r8d                   # r8d = i - 1
  movl arr(,%r8d, 4), %r10d   # r10d = arr[i-1]

  ##movl %r10d, %r14d

  cmpl %r9d, %r10d            
  jle  STEP3

  #MOVE
  movl %r9d, arr(,%r8d, 4)    # arr[i-1] = r9d
  incl %r8d                   # r8d = i
  movl %r10d, arr(,%r8d, 4)   # arr[i] = r10d
  movl $1, %ebx               # ebx = 1, swapped = 1
  jmp STEP3
  
  
STEP5:
  cmpl $0, %ebx
  jne  STEP1


set_counter:
  movl $0, %esi               # counter = 0



load:
  #movl $3, %edi               # edi = i = 0
  movl %esi, %edi               # edi = i = 0
  movl arr(,%edi, 4), %eax    # eax = arr[0]
  addl $0x30, %eax            # eax = eax + 0x30

  movl $0, %edi
  movb %al, str(,%edi,1)

print:
  movl $4, %eax
  movl $1, %ebx
  movl $str, %ecx
  movl $1, %edx
  int  $0x80

  movl $4, %eax
  movl $1, %ebx
  movl $str+1, %ecx
  movl $1, %edx
  int  $0x80

  incl %esi                   # counter ++
  cmpl %esi, %r14d            # if (counter != ALEN ) then (jump to load)
  jne  load

newline:
  movl $4, %eax
  movl $1, %ebx
  movl $str+2, %ecx
  movl $1, %edx
  int  $0x80

exit:
  movl $1, %eax
  movl $0, %ebx
  int  $0x80
