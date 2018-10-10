;// Trevor Latchana
;// Assembly Language Programming CS 397
;// Instructor: Dr. Amenyo
;// 32 Bit Version
;// App # 9  Grade calculator for a single course taken in a semester
;//A) First write the code to supports the calculation of a letter grade for N=1 student, with K=5 raw scores.
;//Devise your own grading table for (A+, A, A-, B+, B, B-, C+,C, C-, D+, D, F)
;//B) Extend to code that supports the calculation of letter grades for at least N=10 students, each with K=10 raw scores. 
;// Devise your own grading table.Also support the determination of the Minimum, Maximum, Mean scores obtained in the class, as well as the Median scores and Modes.
;// For each letter grade, calculate the number and percent of students who received that grade.


INCLUDE Irvine32.inc

.data
	K DWORD 10       ;// Represent the number of raw scores per student
	N DWORD 10        ;// Represent the number of students

	scorePrompt    BYTE "Please enter the student scores: ", 0
	out_of_range   BYTE "The average is either below 0 or above 100", 0
	studentGrade   BYTE " Is the students grade.", 0

	;//Grading Table Variables
	gradeA      BYTE "A" ,0
	gradeAmin   BYTE "A-",0
	gradeAplus  BYTE "A+",0
	gradeB      BYTE "B" ,0
	gradeBmin   BYTE "B-",0
	gradeBplus  BYTE "B+",0
	gradeC      BYTE "C" ,0
	gradeCmin   BYTE "C-",0
	gradeCplus  BYTE "C+",0
	gradeD      BYTE "D" ,0
	gradeDplus  BYTE "D+",0
	gradeF      BYTE "F" ,0

;//These counters are used in order to calculate the mode in the terms of a fractional output.
	gradeAcount      DWORD 0
	gradeAmincount   DWORD 0
	gradeApluscount  DWORD 0
	gradeBcount      DWORD 0
	gradeBmincount   DWORD 0
	gradeBpluscount  DWORD 0
	gradeCcount      DWORD 0
	gradeCmincount   DWORD 0
	gradeCpluscount  DWORD 0
	gradeDcount      DWORD 0
	gradeDpluscount  DWORD 0
	gradeFcount      DWORD 0

	minClassScore    DWORD ?
	maxClassScore    DWORD ?
	meanClassScore   DWORD ? 
	medianClassScore DWORD ?

	stringClassMIN        BYTE "The minimum value the class is: ", 0
	stringClassMAX        BYTE "The maximum value the class is: ", 0
	stringClassMEAN       BYTE "The mean of value the class is ", 0
	stringClassMEDIAN     BYTE "The median value the class is: ", 0

	stringModePompt  BYTE "Mode display for letter grades recived by 10 students: ", 0
	stringMode       BYTE "/10 students received the following grade ", 0
	
	scoresArray DWORD 10 DUP(?)
	gradesArray DWORD 10 DUP(?)

.code
main proc

MOV ECX, N
MOV EDI, 0
MOV ESI, OFFSET gradesArray
;// The M1 will run for 10 cycles for the 10 students.
M1:
	PUSH ECX

		MOV EDX, OFFSET scorePrompt
		call WriteString
		call crlf
		mov ESI, OFFSET scoresArray
		mov EBX, 0
		mov ECX, K

	;//Collects the scores
	L1: 
		call ReadInt
		mov [scoresArray+EBX], EAX
		ADD EBX, 4
		LOOP L1

		mov ecx, K
		mov EDX, 0
		mov EBX, 0
		call crlf

	;//Finds the Sum the scores in the array
	L2: 
		mov EAX, [scoresArray+EBX]
		ADD EBX, 4
		ADD EDX, EAX
		LOOP L2

		call MeanCalc   ;// Mean value is returned via EAX register
	
	;// This segment of code begins to insert the final average per student into the gradesArray
		MOV [gradesArray+EDI], EAX
		ADD EDI, TYPE gradesArray

		call GradeCalc    ;// Uses the Mean score that is already in EAX when it is called in order to determine the letter grade.

	POP ECX
	DEC ECX
	CMP ECX, 0
	JNE M1

	mov ECX, N
	mov EDI, 0

COMMENT @  ;// Displays the array of the students average grades.
arryPrint1:
	mov EAX, [gradesArray+EDI]
	ADD EDI, 4
	call writeInt
	call crlf
	loop arryPrint1
@


;//BubbleSort from the highest to lowest value.
;//I used the bubble sort provided by professor Kip Irvine from the test Assembly Language for x86 processors on page 
;//375 and made changes to it, in order to use it in the.code section instead of as a procedure.
	Mov ECX, N
	DEC ECX

	Outter:
			MOV EBX, ECX
			MOV EDI, 0
			NextComp :
			MOV EAX, [gradesArray+EDI]
			MOV EDX, [gradesArray+EDI+4]
			CMP EAX, EDX
			JNC DontSwap

			;// Will swap the elements if no jump is taken.
			MOV [gradesArray+EDI], EDX
			MOV [gradesArray+EDI+4], EAX
		
	DontSwap:
			ADD EDI, 4
			DEC EBX
			JNZ NextComp
			LOOP Outter


	mov ECX, N
	mov EDI, 0
	call crlf

	mov EAX, [gradesArray+36]
	mov minClassScore, EAX
	mov EAX, [gradesArray+0]
	mov maxClassScore, EAX

COMMENT @ ;// Displays the grades array after it has been sorted and the min and max have been stored.
arryPrint2:
	mov EAX, [gradesArray+EDI]
	ADD EDI, 4
	call writeInt
	call crlf
	loop arryPrint2
@
	;// These are the two middle values for an array of an even Index, If the array was odd numbered the middle value would have been the Median.
	MOV EAX, [gradesArray+20]
	MOV EBX, [gradesArray+16]

	PUSH EAX
	PUSH EBX
	
	call MedianCalc

	POP EBX
	POP EAX

;// Small loop to find the sum gradesArray which we will then call MeanCalc to return us the average.
	MOV EBX, 0
	MOV ECX, N
	MOV EDX, 0
C1:
	mov EAX, [gradesArray+EBX]
	ADD EBX, 4
	ADD EDX, EAX
	LOOP C1

	call MeanCalc

	MOV  meanClassScore, EAX  ;// MeanCalc returns the average in the EAX register.


;//Now to display all of the final data to the console.

	call ModeCalc;// variables are passed via local declartions from the .data section.
	call CrLf 

	MOV EDX, OFFSET stringClassMIN
	call WriteString
	MOV EAX, minClassScore
	call WriteInt
	call CrLf

	MOV EDX, OFFSET stringClassMAX
	call WriteString
	MOV EAX, maxClassScore
	call WriteInt
	call CrLf

	MOV EDX, OFFSET stringClassMEAN
	call WriteString
	MOV EAX, meanClassScore
	call WriteInt
	call CrLf

	MOV EDX, OFFSET stringClassMEDIAN
	call WriteString
	MOV EAX, medianClassScore
	call WriteInt
	call CrLf


call Waitmsg

exit
main endp
;//***************************************************************************************************************************************
MedianCalc PROC
	PUSH EBP
	MOV EBP, ESP
	MOV EDX, 0
	ADD EDX, [EBP+8]
	ADD EDX, [EBP+12]
	
	MOV EAX, EDX
	MOV EDX, 0
	MOV ECX, 2
	DIV ECX

	MOV medianClassScore, EAX

	POP EBP
ret
MedianCalc ENDP

;//***************************************************************************************************************************************
MeanCalc PROC
;// Uses the value in EDX and finds the MeanScore and returns the result in EAX
	mov EAX, EDX
	mov EDX, 0       ;// Clearing the EDX register because the DIV instruction will store a remainder here. Not needed but good practice. 
	mov ECX, N
	DIV ECX
ret
MeanCalc ENDP

;//***************************************************************************************************************************************
ModeCalc PROC
;// Will display the mode of the total grades given for the 10 students. Which is how many students get which letter grade.
	MOV EDX, OFFSET stringModePompt
	Call WriteString 
	call CrLf

;// These following blocks of code will neatly display the Mode for the final result of the 10 students.
	mov EAX, gradeApluscount
	call WriteInt 
	MOV EDX, OFFSET stringMode
	call WriteString
	MOV EDX, OFFSET gradeAPlus
	call WriteString
	call crlf

	mov EAX, gradeAmincount
	call WriteInt
	MOV EDX, OFFSET stringMode
	call WriteString
	MOV EDX, OFFSET gradeAmin
	call WriteString
	call crlf

	mov EAX, gradeAcount
	call WriteInt
	MOV EDX, OFFSET stringMode
	call WriteString
	MOV EDX, OFFSET gradeA
	call WriteString
	call crlf

	mov EAX, gradeBpluscount
	call WriteInt
	MOV EDX, OFFSET stringMode
	call WriteString
	MOV EDX, OFFSET gradeBPlus
	call WriteString
	call crlf

	mov EAX, gradeBmincount
	call WriteInt
	MOV EDX, OFFSET stringMode
	call WriteString
	MOV EDX, OFFSET gradeBmin
	call WriteString
	call crlf

	mov EAX, gradeBcount
	call WriteInt
	MOV EDX, OFFSET stringMode
	call WriteString
	MOV EDX, OFFSET gradeB
	call WriteString
	call crlf

	mov EAX, gradeCpluscount
	call WriteInt
	MOV EDX, OFFSET stringMode
	call WriteString
	MOV EDX, OFFSET gradeCPlus
	call WriteString
	call crlf

	mov EAX, gradeCcount
	call WriteInt
	MOV EDX, OFFSET stringMode
	call WriteString
	MOV EDX, OFFSET gradeC
	call WriteString
	call crlf

	mov EAX, gradeCmincount
	call WriteInt
	MOV EDX, OFFSET stringMode
	call WriteString
	MOV EDX, OFFSET gradeCmin
	call WriteString
	call crlf

	mov EAX, gradeDpluscount
	call WriteInt
	MOV EDX, OFFSET stringMode
	call WriteString
	MOV EDX, OFFSET gradeDPlus
	call WriteString
	call crlf

	mov EAX, gradeDcount
	call WriteInt
	MOV EDX, OFFSET stringMode
	call WriteString
	MOV EDX, OFFSET gradeD
	call WriteString
	call crlf

	mov EAX, gradeFcount
	call WriteInt
	MOV EDX, OFFSET stringMode
	call WriteString
	MOV EDX, OFFSET gradeF
	call WriteString
	call crlf

ret
ModeCalc ENDP

;//***************************************************************************************************************************************
GradeCalc PROC
;//If directive mentioned in professor Irvine's textbook chapter 10 page 423
;//Uses the average of the scores to assign a letter grade and prints the letter grade to the console
;//Added the ability to keep a count of how many times a specific grade is given in order to scale the program to 10 students from 1.
	
.IF (eax <= 100 && eax >= 0)
	.IF (eax <= 100) && (eax >= 97)
		mov EDX, OFFSET gradeAplus
		call WriteString
		mov EDX, OFFSET studentGrade
		call WriteString
		call crlf
		mov EBX, gradeApluscount
		INC EBX
		mov gradeApluscount, EBX

	.ELSEIF (eax <= 96) && (eax >= 93)
		mov EDX, OFFSET gradeA
		call WriteString
		mov EDX, OFFSET studentGrade
		call WriteString
		call crlf
		mov EBX, gradeAcount
		INC EBX

		mov gradeAcount, EBX
	.ELSEIF (eax <= 93) && (eax >= 90)
		mov EDX, OFFSET gradeAmin
		call WriteString
		mov EDX, OFFSET studentGrade
		call WriteString
		call crlf
		mov EBX, gradeAmincount
		INC EBX
		mov gradeAmincount, EBX

	.ELSEIF (eax <= 89) && (eax >= 87)
		mov EDX, OFFSET gradeBplus
		call WriteString
		mov EDX, OFFSET studentGrade
		call WriteString
		call crlf
		mov EBX, gradeBpluscount
		INC EBX
		mov gradeBpluscount, EBX

	.ELSEIF (eax <= 86) && (eax >= 83)
		mov EDX, OFFSET gradeB
		call WriteString
		mov EDX, OFFSET studentGrade
		call WriteString
		call crlf
		mov EBX, gradeBcount
		INC EBX
		mov gradeBcount, EBX

	.ELSEIF (eax <= 82) && (eax >= 80)
		mov EDX, OFFSET gradeBmin
		call WriteString
		mov EDX, OFFSET studentGrade
		call WriteString
		call crlf
		mov EBX, gradeBmincount
		INC EBX
		mov gradeBmincount, EBX

	.ELSEIF (eax <= 79) && (eax >= 77)
		mov EDX, OFFSET gradeCplus
		call WriteString
		mov EDX, OFFSET studentGrade
		call WriteString
		call crlf
		mov EBX, gradeCpluscount
		INC EBX
		mov gradeCpluscount, EBX

	.ELSEIF (eax <= 76) && (eax >= 73)
		mov EDX, OFFSET gradeC
		call WriteString
		mov EDX, OFFSET studentGrade
		call WriteString
		call crlf
		mov EBX, gradeCcount
		INC EBX
		mov gradeCcount, EBX

	.ELSEIF (eax <= 72) && (eax >= 70)
		mov EDX, OFFSET gradeCmin
		call WriteString
		mov EDX, OFFSET studentGrade
		call WriteString
		call crlf
		mov EBX, gradeCmincount
		INC EBX
		mov gradeCmincount, EBX

	.ELSEIF (eax <= 69) && (eax >= 67)
		mov EDX, OFFSET gradeDplus
		call WriteString
		mov EDX, OFFSET studentGrade
		call WriteString
		call crlf
		mov EBX, gradeDpluscount
		INC EBX
		mov gradeDpluscount, EBX

	.ELSEIF (eax <= 66) && (eax >= 60)
		mov EDX, OFFSET gradeD
		call WriteString
		mov EDX, OFFSET studentGrade
		call WriteString
		call crlf
		mov EBX, gradeDcount
		INC EBX
		mov gradeDcount, EBX

	.ELSEIF (eax <= 59) && (eax >= 0)
		mov EDX, OFFSET gradeF
		call WriteString
		mov EDX, OFFSET studentGrade
		call WriteString
		call crlf
		mov EBX, gradeFcount
		INC EBX
		mov gradeFcount, EBX

	.ENDIF
;// Fall through statement in the event the average is above 100.
.ELSE
	mov edx,OFFSET out_of_range
	call WriteString
	call Crlf
	ret
.ENDIF

ret
GradeCalc ENDP
;//***************************************************************************************************************************************

end main
