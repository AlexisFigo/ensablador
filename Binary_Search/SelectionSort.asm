TITLE  SelectionSort Procedure                  (SelectionSort.asm)

INCLUDE Irvine32.inc


.code
;----------------------------------------------------------
SelectionSort PROC USES eax ecx esi,
	myArray:PTR DWORD,		; pointer to array
	Count:DWORD			; array size
;
; Sort an array of 32-bit signed integers in ascending order
; using the bubble sort algorithm.
; Receives: pointer to array, array size
; Returns: nothing
;-----------------------------------------------------------

    call Clrscr
    MOV EDI, myArray
    MOV ECX, Count


    MOV EDI, myArray
    MOV ECX, Count
    CALL SORT_ARRAY

    CALL CRLF
    MOV EDI, myArray
    MOV ECX, Count
    CALL PRINT_ARRAY

;-----------------------------------------------------------------------------
PRINT_ARRAY:
; requires edi to be pointing to an array
; requires ecx to be the length of the array
;-----------------------------------------------------------------------------
ARRAYLOOP: MOV EAX, [EDI]
           CALL WRITEINT
           CALL CRLF
           ADD EDI, TYPE myArray
           LOOP ARRAYLOOP
           ret

;-----------------------------------------------------------------------------
SORT_ARRAY:
; requires edi to be pointing to an array
; requires ecx to be the length of the array
; 
; ebp points to the minimum value
; esp points to edi + 1 (4 in our case) 
;-----------------------------------------------------------------------------
PUSHAD                          ; push all our registers.. dont want to modify 



OUTER_LOOP: MOV EBX, ECX        ; ebx = inner looper counter
            DEC EBX             ; dont want to compare same offset
                                ; we want it one less in the ebx count  

            MOV EBP, EDI        ; assign our min value array OFFSET
            MOV ESP, EDI        ; our value of j which we will inc      
            ADD ESP, TYPE[EDI]  ; j = i + 1

INNER_LOOP: MOV EAX, [EBP]      ; save our min VALUE to a register

            ; ESP (j)  < EAX (min) ?
            CMP [ESP], EAX  

            ; no, its greater, skip this value
            JGE SKIP_ARRAY_VALUE

            ; yes, array value is less than min
            ; save a new min value
            MOV EBP, ESP

            SKIP_ARRAY_VALUE:

            ADD ESP, TYPE[EDI]
            ; decrement our counter
            DEC EBX

            ; if ebx didnt set the zero flag, keep looping
            JNZ INNER_LOOP

            ; move our min value into the position of edi, and move edi 
            ; to the position of the min value

            MOV EDX, [EDI]                  ; edx = numbers[i]
            MOV EAX, [EBP]                  ; eax = numbers[min] 
            MOV [EDI], EAX                  ; numbers[i] = numbers[min]
            MOV [EBP], EDX                  ; numbers[min] = numbers[i]

            INC EDI
            LOOP OUTER_LOOP

POPAD                           ; pop all registers


RET
 
SelectionSort ENDP

 
END