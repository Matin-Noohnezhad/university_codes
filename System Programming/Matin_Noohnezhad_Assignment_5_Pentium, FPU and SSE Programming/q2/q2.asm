.386
.xmm
.model flat, stdcall
option casemap:none

include \masm32\include\windows.inc
include \masm32\include\masm32.inc
include \masm32\include\msvcrt.inc
include \masm32\include\kernel32.inc

includelib \masm32\lib\masm32.lib
includelib \masm32\lib\msvcrt.lib
includelib \masm32\lib\kernel32.lib

SumPrinter proto :dword, :dword, :dword, :dword, :dword, :dword
MulPrinter proto :dword, :dword, :dword, :dword, :dword, :dword

.data
	addPrnt db "The sum of %f and %f is = %f ",10,0
	mulPrnt db "The mul of %f and %f is = %f ",10,0
	FirstFloats db "enter first set of 6 float numbers:",0
	SecondFloats db "enter second set of 6 float numbers:",0
	sixFloat db "%f %f %f %f %f %f",0
	newLine db 10


.data?
	arr1 dd 6 dup(?)
	nothing dd 2 dup(?)
	arr2 dd 6 dup(?)
	nothing2 dd 2 dup(?)
	arr3 dd 6 dup(?)
	nothing3 dd 2 dup(?)
	firstData dq ?
	secondData dq ?
	ansData dq ?

.code 
start:
	invoke crt_printf, offset FirstFloats
	invoke crt_scanf, offset sixFloat, offset arr1, offset arr1+4, offset arr1+8, offset arr1+12, offset arr1+16, offset arr1+20
	invoke crt_printf, offset newLine
	invoke crt_printf, offset SecondFloats
	invoke crt_scanf, offset sixFloat, offset arr2, offset arr2+4, offset arr2+8, offset arr2+12, offset arr2+16, offset arr2+20
	invoke crt_printf, offset newLine

	vmovaps ymm0, dword ptr[arr1]
	vmovaps ymm1, dword ptr[arr2]
	vaddps	ymm2,ymm0,ymm1
	vmovaps dword ptr[arr3], ymm2
	invoke SumPrinter, arr1, arr2, arr3, offset firstData, offset secondData, offset ansData
	invoke SumPrinter, arr1+4, arr2+4, arr3+4, offset firstData, offset secondData, offset ansData
	invoke SumPrinter, arr1+8, arr2+8, arr3+8, offset firstData, offset secondData, offset ansData
	invoke SumPrinter, arr1+12, arr2+12, arr3+12, offset firstData, offset secondData, offset ansData
	invoke SumPrinter, arr1+16, arr2+16, arr3+16, offset firstData, offset secondData, offset ansData
	invoke SumPrinter, arr1+20, arr2+20, arr3+20, offset firstData, offset secondData, offset ansData
	invoke crt_printf, offset newLine
	vmovaps ymm0, dword ptr[arr1]
	vmovaps ymm1, dword ptr[arr2]
	vmulps	ymm2,ymm0,ymm1
	vmovaps dword ptr[arr3], ymm2
	invoke MulPrinter, arr1, arr2, arr3, offset firstData, offset secondData, offset ansData
	invoke MulPrinter, arr1+4, arr2+4, arr3+4, offset firstData, offset secondData, offset ansData
	invoke MulPrinter, arr1+8, arr2+8, arr3+8, offset firstData, offset secondData, offset ansData
	invoke MulPrinter, arr1+12, arr2+12, arr3+12, offset firstData, offset secondData, offset ansData
	invoke MulPrinter, arr1+16, arr2+16, arr3+16, offset firstData, offset secondData, offset ansData
	invoke MulPrinter, arr1+20, arr2+20, arr3+20, offset firstData, offset secondData, offset ansData
	invoke ExitProcess,0

SumPrinter proc memFirst:dword, memSecond:dword, memAns:dword, firstDouble:dword, secondDouble:dword, ansDouble:dword
	fld dword ptr[memAns]
	fstp qword ptr[ansDouble]
	fld dword ptr[memSecond]
	fstp qword ptr[secondDouble]
	fld dword ptr[memFirst]
	fstp qword ptr[firstDouble]
	invoke crt_printf, offset addPrnt, qword ptr[firstDouble], qword ptr[secondDouble], qword ptr[ansDouble]
	ret
SumPrinter endp
MulPrinter proc memFirst:dword, memSecond:dword, memAns:dword, firstDouble:dword, secondDouble:dword, ansDouble:dword
	fld dword ptr[memAns]
	fstp qword ptr[ansDouble]
	fld dword ptr[memSecond]
	fstp qword ptr[secondDouble]
	fld dword ptr[memFirst]
	fstp qword ptr[firstDouble]
	invoke crt_printf, offset mulPrnt, qword ptr[firstDouble], qword ptr[secondDouble], qword ptr[ansDouble]
	ret
MulPrinter endp
end start
