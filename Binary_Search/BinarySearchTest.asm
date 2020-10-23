TITLE Bubble Sort and Binary Search       BinarySearchTest.asm)

; Bubble sort an array of signed integers, and perform
; a binary search.
; Main module, calls Bsearch.asm, Bsort.asm, FillArry.asm

INCLUDE Irvine32.inc
INCLUDE BinarySearch.inc		; procedure prototypes

LOWVAL = -5000			; minimum value
HIGHVAL = +5000		; maximum value
ARRAY_SIZE = 1000		; size of the array

.data
array DWORD ARRAY_SIZE DUP(?)
startTime DWORD ?
counter   BYTE "Tiempo de Ordenamiento por Inserci�n de 50 elementos: ",0

.code
main PROC
	call Randomize

	; Fill an array with random signed integers
	INVOKE FillArray, ADDR array, ARRAY_SIZE, LOWVAL, HIGHVAL

	; Display the array
	INVOKE PrintArray, ADDR array, ARRAY_SIZE
	call	WaitMsg

	call   Clrscr
	INVOKE GetTickCount
	mov    startTime,eax

	; Perform a bubble sort and redisplay the array
	;INVOKE SelectionSort, ADDR array, ARRAY_SIZE
	;INVOKE BubbleSort, ADDR array, ARRAY_SIZE
	INVOKE InsertionSort, ADDR array, ARRAY_SIZE

	INVOKE GetTickCount
	sub    eax,startTime
	mov    edx, OFFSET counter
	call   WriteString
	call   WriteDec
	call   Crlf

	INVOKE PrintArray, ADDR array, ARRAY_SIZE

	; Demonstrate a binary search
	call AskForSearchVal		; returned in EAX
	INVOKE BinarySearch,
	  ADDR array, ARRAY_SIZE, eax
	call	ShowResults

	exit
main ENDP

;--------------------------------------------------------
AskForSearchVal PROC
;
; Prompt the user for a signed integer.
; Receives: nothing
; Returns: EAX = value input by user
;--------------------------------------------------------
.data
prompt BYTE "Enter a signed decimal integer "
       BYTE "to find in the array: ",0
.code
	call	Crlf
	mov	edx,OFFSET prompt
	call	WriteString
	call	ReadInt
	ret
AskForSearchVal ENDP

;--------------------------------------------------------
ShowResults PROC
;
; Display the resulting value from the binary search.
; Receives: EAX = position number to be displayed
; Returns: nothing
;--------------------------------------------------------
.data
msg1 BYTE "The value was not found.",0
msg2 BYTE "The value was found at position ",0
.code
.IF eax == -1
	mov	edx,OFFSET msg1
	call	WriteString
.ELSE
	mov	edx,OFFSET msg2
	call	WriteString
	call	WriteDec
.ENDIF
	call	Crlf
	call	Crlf
	ret
ShowResults ENDP

END main