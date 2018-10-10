;Trevor Latchana CS 397
;Project # 1,  Professor Amenyo

INCLUDE Irvine32.inc


.data


;//#1 variable
	Number  SDWORD -300

;//#2, 3, 4, 5 and 6 variables
	Number1 DWORD 10
	Number2 DWORD 6
	Sum     DWORD ?
	Diff    DWORD 0

	stringSumPrompt  BYTE "Please enter 3 integers and press  the 'Enter Key' after each integer: ", 0
	stringSum		 BYTE "The sum of your three numbers is: ", 0
	stringDiffPrompt BYTE "Please enter 2 integers and press the 'Enter Key' after each integer: ", 0
	stringDiff		 BYTE "The difference of your two numbers is: ", 0

;//#7 and 8 variables
	Value1  DWORD 100
	Value2  DWORD 200
	Value3  DWORD 300

;//#9 variables
	xVal	DWORD ?
	yVal	DWORD ?
	zVal	DWORD ?
	Result9A DWORD ?
	Result9B DWORD ?

;//#10 variables
	valLength DWORD ?
	valHeight DWORD ?
	valWidth  DWORD ?
	stringCuboid BYTE "Please enter the length, width and height of the cuboid: ", 0
	Perimeter DWORD ?

;//#11 variables
	Num11Prompt BYTE "Please enter 4 integers, pressing the 'Enter Key' after every integer: ", 0
	BVar1 BYTE ?
	BVar2 BYTE ?
	BVar3 BYTE ?
	BVar4 BYTE ?

	DVar1 DWORD ?
	DVar2 DWORD ?
	DVar3 DWORD ?
	DVar4 DWORD ?

	SDVar1 SDWORD ?
	SDVar2 SDWORD ?
	SDVar3 SDWORD ?
	SDVar4 SDWORD ?

;//#12 variables
	Var1 DWORD ?
	Var2 DWORD ?
	Num12Prompt BYTE "Please enter two numbers: ", 0

;//#13 variables
	integerArray DWORD 100 DUP(?)
	stringSpace BYTE ", ", 0

;//#14 variables
	FirstName1   BYTE 30 DUP(? )
	MiddleName1  BYTE 30 DUP(? )
	LastName1    BYTE 30 DUP(? )
	stringFirst   BYTE "Please enter your first name: ", 0
	stringMiddle  BYTE "Please enter your middle name: ", 0
	stringLast    BYTE "Please enter your last name: ", 0


;//#15 variables
	ArrayStudentInfo  BYTE 100 DUP(60 DUP(?))
	NumOfStudents     DWORD ?
	infoPrompt        BYTE  "Please enter your Last Name, Middle Name, First Name and Student ID: ", 0
	stringNumStudents BYTE  "Please enter the number of students", 0
	listPrompt        BYTE  "Here is the list of the entered students: ", 0

;//#16 Variables
	lAval DWORD ?
	lBval DWORD ?
	lCval DWORD ?
	lDval DWORD ?
	lEval DWORD ?
	lFval DWORD ?
	lGval DWORD ?
	lHval DWORD ?
	Num16Prompt        BYTE "The resulting numbers listed in the following order A, B, C, D, E, F, G, H", 0


;// # 17 Variables
	LengthValue DWORD ?
	WidthValue  DWORD ?
	AreaValue   DWORD ? 
	PerimeterValue DWORD ?
	QuotientValue  DWORD ? 
	RemainderValue DWORD ?
	Num17Prompt BYTE "Please enter the Length and Width values (press enter after each value): ", 0
	qPrompt   BYTE  "The quotient is: ", 0
	rPrompt   BYTE  "The reminader is: ", 0

	stringletterPrompt BYTE "Please enter 3 numbers while pressing 'enter' after each number", 0


.code
main proc


;//Part 1

COMMENT @

;//#1) Change the value of variable Number to -253.
	MOV Number, -253

;//#2) Add the value 74 to the value in EAX.
	ADD EAX, 74

;//#3) Add the two numbers stored in memory at Number1 and Number2, and store the total at the memory location named Sum.
	MOV EDX, Number2
	MOV EAX, Number1
	ADD EAX, EDX
	MOV Sum, EAX

;//#4) Subtract 1000 from the value store in memory location named Number.
	MOV EAX, Number
	MOV EDX, 1000
	SUB EAX, EDX
	mov EDX, EAX


;//#5) Prompt for three (3) integer values from the user, add them, print or display the sum, as well as store it in the memory location declared as Sum.
	MOV EDX, OFFSET stringSumPrompt
	call crlf
	call Writestring
	call crlf

	call ReadInt
	MOV Number, EAX
	MOV EDX, EAX

	call ReadInt
	MOV Number1, EAX
	ADD EDX, EAX

	call ReadInt
	MOV Number2, EAX
	ADD EDX, EAX
	MOV Sum, EDX

	MOV EDX, OFFSET stringSum
	call WriteString
	MOV EAX, Sum
	call WriteInt
	call crlf


;//#6) Prompt for two integers from the user. Subtract the first from the second, display and result, and also store in a variable declared as Diff.
    
	MOV EDX, OFFSET stringDiffPrompt
	call crlf
	call Writestring
	call crlf

	call ReadInt
	MOV Number1, EAX

	call ReadInt

	SUB EAX, Number1
	MOV Diff, EAX

	MOV EDX, OFFSET stringDiff
	call WriteString
	MOV EAX, Diff
	call WriteInt
	call crlf

;//#7) Use MOV based instructions to swap values stored at Value1, Value2 and Value3.
	
	MOV EAX, Value1
	MOV EBX, EAX

	MOV EAX, Value2
	MOV Value1, EAX

	MOV EAX, Value3
	MOV Value2, EAX

	MOV EAX, EBX
	MOV Value3, EAX

	MOV EBX, 0

;//#8)Use XCHG based instructions to swap values stored at Value1, Value2 and Value3.

	MOV EAX, Value1
	MOV EBX, Value2
	MOV ECX, Value3

	XCHG EAX, EBX
	XCHG EAX, ECX
	MOV  Value1, EAX
	MOV  Value2, EBX
	MOV  Value3, ECX

;//#9) Multiply without mul or iMul for the expression  X-5Y+6Z, the values for X can be from 1-31, Y can be 1-12, Z can be any 4-digit year value.

	MOV xVal, 25
	MOV EAX, 5
    SHL EAX, 3 ;//3 left shifts is the same as multiplying 5 by 8 which is 2 to the power 3.
	MOV yVal, EAX
	MOV EAX, 6
	SHL EAX, 11  ;//10 left shifts is the same as multiplying 6 by 2048 which is 2 to the power 11.
	MOV zVal, EAX

	MOV EAX, xVal
	SUB EAX, yVAL
	ADD EAX, zVal
	MOV Result9A, EAX

;//#9) Multiply using mul for the expression X-5Y+6Z, the values for X can be from 1-31, Y can be 1-12, Z can be any 4-digit year value.

	MOV EDX, 8
	MOV EAX, 5
	MUL EDX
	MOV yVal, EAX
	MOV EDX, 6
	MOV EAX, 2048
	MUL EDX
	MOV zVal, EAX

	MOV EAX, xVal
	SUB EAX, yVal
	ADD EAX, zVal
	MOV Result9B, EAX

;//#10) Prompt the use for the Length, Width and Height values of a cuboid, and compute and display the value of the expression 4 * Length + 4 * Width + 2 * Height.
;//Also store the result in the variable Perimeter.Assume the MULtiply instruction is unavailable.

	MOV EDX, OFFSET stringCuboid
	call crlf
	call Writestring
	call crlf

	call ReadInt
	SHL EAX, 2
	MOV ValLength, EAX
	call ReadInt
	SHL EAX, 2
	MOV ValWidth, EAX
	call ReadInt
	SHL EAX, 1
	MOV ValHeight, EAX

	MOV EDX, valLength
	ADD EDX, valWidth
	ADD EDX, valHeight
	MOV Perimeter, EDX
	MOV EAX, EDX
	call CrLf
	call WriteInt
	call CrLf

;//#11) Declare 8 - bit variables, BVar1, BVar2, BVar3 and BVar4, as well as 32 - bit variables, DVar1, DVar2, DVar3 and DVar4.
;//Prompt the user for the values to store in BVar1, Bvar2, BVar3 and BVar4. Then store these values in the corresponding DVar1, 
;//DVar2, DVar3 and DVar4, a) using Zero - Extension and b) Sign - Extension instructions.



	MOV EDX, OFFSET Num11Prompt
	call crlf
	call Writestring
	call crlf

	call ReadInt
	MOV BVar1, AL
	MOVZX EAX, AL
	MOV DVar1, EAX
	MOVSX EAX, AL
	MOV SDVar1, EAX

	call ReadInt
	MOV BVar2, AL
	MOVZX EAX, AL
	MOV DVar2, EAX
	MOVSX EAX, AL
	MOV SDVar2, EAX

	call ReadInt
	MOV BVar3, AL
	MOVZX EAX, AL
	MOV DVar3, EAX
	MOVSX EAX, AL
	MOV SDVar3, EAX

	call ReadInt
	MOV BVar4, AL
	MOVZX EAX, AL
	MOV DVar4, EAX
	MOVSX EAX, AL
	MOV SDVar4, EAX

;//#12) Prompt the user for values to store in Var1 and Var2. Then evaluate and display the result for (Var2 - Var1) + (Var1 - Var2), 
;// using only INCrement and DECrement instructions.

	MOV EDX, OFFSET Num12Prompt
	call crlf
	call Writestring
	call crlf

	call ReadInt
	MOV Var1, EAX
	call ReadInt
	call CrLf
	MOV Var2, EAX

	MOV ECX, 0
L1:
	DEC EAX
	INC ECX
	CMP ECX, Var1
	JNE L1

	MOV EDX, EAX

	MOV EAX, Var1
	MOV ECX, 0
L2:
	DEC EAX
	INC ECX
	CMP ECX, Var2
	JNE L2

	MOV EBX, EAX

	MOV ECX, 0
L3:
	INC EDX
	INC ECX
	CMP ECX, EBX
	JNE L3

	mov EAX, EDX
	CALL Writeint
	call CrLf

;//#13)Declare and organize memory space to store a list of 100 integer values. 
;//Write the code to display the values stored in the list (Hint: Use the LOOP instruction).

	mov ESI, OFFSET integerArray
	mov EAX, 0
	mov ECX, 0
;//Fills the array
A1:
	mov [ESI+EAX],ECX
	inc ECX
	ADD EAX, TYPE integerArray
	CMP ECX, 100
	JNE  A1

;//Displays the array to the console for testing purposes.
	mov EBX, 0
	mov ECX, 0
A2:
	MOV EAX, [ESI+EBX]
	call WriteDec
	mov EDX, OFFSET stringSpace
	call WriteString
	add EBX, 4
	inc ECX
	CMP ECX, 100
	JNE A2

;//14) Declare and organize memory space to store the LastName, FirstName and MiddleName of a Patient.
;//Prompt the user to input the names for a patient and store the inputs in the declared variables.

;//first name 
	MOV EDX, OFFSET stringFirst
	call WriteString
	mov EDX, OFFSET FirstName1
	mov ECX, SIZEOF FirstName1-1
	call ReadString
	call crlf

;//middle name
	mov EDX, OFFSET stringMiddle
	call WriteString
	mov EDX, OFFSET MiddleName1
	mov ECX, SIZEOF MiddleName1-1
	call ReadString
	call crlf

;//last name
	mov EDX, OFFSET stringLast
	call WriteString
	mov EDX, OFFSET LastName1
	mov ECX, SIZEOF LastName1-1
	call ReadString
	call crlf
@

;//#15 Declare and organize memory space to store the LastName, FirstName, MiddleName and Id for 100
;//students in a University department. Write the code to prompt the user to input the actual number of
;//students registered in a particular semester, and then display the records for these students.
;//(Hint: use the LOOP instruction).

;//Number of Students registered 
	MOV EDX, OFFSET stringNumStudents
	call WriteString
	call crlf
	call ReadInt
	mov NumOfStudents, EAX
	mov EBX, EAX
	mov EDI, 0
	mov ESI, OFFSET ArrayStudentInfo

	mov EDX, OFFSET infoPrompt
	call WriteString
M1:
	call crlf
	LEA EDX, [ESI+EDI]
	mov ECX, 59
	call ReadString

	ADD EDI, 60
	DEC EBX
	CMP EBX, 0
	JNE M1

	mov EDI, 0
	mov EBX, NumOfStudents
	mov EBP, 0 

	mov EDX, OFFSET listPrompt
	call WriteString
	call crlf
M2:
	call crlf
	LEA EDX, [ESI+EDI]
	call writestring
	call crlf
	ADD EDI, 60
	DEC EBX
	CMP EBX, 0
	JNE M2


COMMENT @
;//#16 Prompt the user for the values of A, B, C. Calculate: D = A + B+ C; E = A – B – C + D; F = A – (B – C)
;//G = 8B + 71A – 80C; H = – ( – A + 2B – C + D); perform in sequence. Finally display the values for A, B, C, D, E, F, G, H.
;//Display also the values in all the registers at the end.

;//prompts the user for the values of A,B,C
	mov EDX, OFFSET stringletterPrompt
	call writestring
	call crlf

	call readint
	mov lAval, EAX

	call readint
	mov lBval, EAX

	call readint
	mov lCval, EAX

;//calculates the value for D = A + B + C then stores it into lDVal (Note the value of C was already in eax due to the last readint)
	ADD EAX, lAval
	ADD EAX, lBval
	mov lDval, EAX

;//calculates the value for E = A – B – C + D stores the result in lEval
	mov eax, lAval
	SUB eax, lBval
	SUB eax, lCval
	ADD EAX, lDval
	mov lEval, eax

;//calculates the value for F = A-(B-C) stores the result in lFval
	mov EAX, lAval
	SUB EAX, lBval
	SUB EAX, lCval
	mov lFval, eax

;//calculates the value for G = 8B + 71A – 80C and stores it into lGval
	mov eax, lBval
	mov EDX, 8d
	mul EDX
	mov EBX, Eax; EBX holding the value for 8 * B
	mov EAX, lAval

	mov EDX, 71d
	mul EDX
	mov ECX, EAX; ECX holding the value for 71 * A

	mov eax, lCval
	mov EDX, 80d
	mul EDX

	ADD EBX, ECX
	SUB EBX, EAX
	mov lGval, EBX; //stores the result for G
	mov eax, lGval

;//calculates the value for H = – ( – A + 2B – C + D) and stores it into lHval   (– ( – A + 2B – C + D) is the same as A - 2B + C - D)

	mov EAX, lBval
	mov EDX, 2
	MUL EDX

	mov EBX, lAval
	SUB EBX, EAX
	ADD EBX, lCval
	SUB EBX, lDval
	mov lHval, EBX

	call DumpRegs
;//These following lines just display the results to the console

	mov EDX, OFFSET Num16Prompt
	call WriteString
	call CrLf

	mov EAX, lAval
	call WriteInt
	mov EDX, OFFSET stringSpace
	call WriteString

	mov EAX, lBval
	call WriteInt
	mov EDX, OFFSET stringSpace
	call WriteString

	mov EAX, lCval
	call WriteInt
	mov EDX, OFFSET stringSpace
	call WriteString

	mov EAX, lDval
	call WriteInt
	mov EDX, OFFSET stringSpace
	call WriteString

	mov EAX, lEval
	call WriteInt
	mov EDX, OFFSET stringSpace
	call WriteString

	mov EAX, lFval
	call WriteInt
	mov EDX, OFFSET stringSpace
	call WriteString

	mov EAX, lGval
	call WriteInt
	mov EDX, OFFSET stringSpace
	call WriteString

	mov EAX, lHval
	call WriteInt
	mov EDX, OFFSET stringSpace
	call WriteString
	call CrLf

;//#17 Prompt the user for the values of Length, Width. Calculate and display: Perimeter = 2*Length + 2*Width; Area = Length* Width;
;// Ratio = Area / Perimeter. (Display as quotient and remainder).

	mov EDX, OFFSET Num17Prompt
	call WriteString
	call crlf

	call ReadInt
	mov LengthValue, EAX
	
	call ReadInt
	mov WidthValue, EAX
	
	mov EBX, LengthValue
	SHL EBX, 1

	MOV ECX, WidthValue
	SHL ECX, 1

	ADD EBX, ECX
	Mov PerimeterValue, EBX

	mov EAX, LengthValue
	MOV EDX, WidthValue
	MUL EDX
	mov AreaValue, EAX 

	mov EBX, PerimeterValue
	DIV EBX
	mov QuotientValue, EAX
	mov RemainderValue, EDX

	mov EDX, OFFSET pPrompt
	call WriteString
	mov EAX, PerimeterValue
	call WriteInt
	call crlf

	mov EDX, OFFSET aPrompt
	call WriteString
	mov EAX, AreaValue
	call WriteInt
	call crlf

	mov EDX, OFFSET qPrompt
	call WriteString
	mov EAX, QuotientValue
	call WriteInt
	call crlf

	mov EDX, OFFSET rPrompt
	call WriteString
	mov EAX, RemainderValue
	call WriteInt
	call crlf

@

	call Waitmsg

exit
main ENDP	
END main