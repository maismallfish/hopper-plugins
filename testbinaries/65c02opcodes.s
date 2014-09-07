; Copyright (c) 2014, Alessandro Gatti - frob.it
; All rights reserved.
;
; Redistribution and use in source and binary forms, with or without
; modification, are permitted provided that the following conditions are met:
;
; 1. Redistributions of source code must retain the above copyright notice,
;    this list of conditions and the following disclaimer.
;
; 2. Redistributions in binary form must reproduce the above copyright notice,
;    this list of conditions and the following disclaimer in the documentation
;    and/or other materials provided with the distribution.
;
; THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
; AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
; IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
; ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
; LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
; CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
; SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
; INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
; CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
; ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
; POSSIBILITY OF SUCH DAMAGE.
		
#define ZEROPAGE_0 $0
#define ZEROPAGE_1 $1
#define ZEROPAGE_2 $2
#define ZEROPAGE_3 $3
#define ZEROPAGE_4 $4
#define ZEROPAGE_5 $5
#define ZEROPAGE_6 $6
#define ZEROPAGE_7 $7
#define ZEROPAGE_8 $8
#define ZEROPAGE_9 $9
#define ZEROPAGE_A $a
#define ZEROPAGE_B $b
#define ZEROPAGE_C $c
#define ZEROPAGE_D $d
#define ZEROPAGE_E $e
#define ZEROPAGE_F $f

		*=$1000

row0 		BRK
		ORA (ZEROPAGE_0,X)
		TSB ZEROPAGE_0
		ORA ZEROPAGE_0
		ASL ZEROPAGE_0
		PHP
		ORA $00
		ASL
		TSB datablockabs
		ORA datablockabs
		ASL datablockabs
		JMP row1

row1		BPL row1_target
		ORA (ZEROPAGE_1),Y
row1_target	ORA (ZEROPAGE_1)
		TRB ZEROPAGE_1
		ORA ZEROPAGE_1,X
		ASL ZEROPAGE_1,X
		CLC
		ORA datablockabs,Y
		INC
		TRB datablockabs
		ORA datablockabs,X
		ASL datablockabs,X
		JMP row2

row2		JSR farcode
		AND (ZEROPAGE_2,X)
		BIT ZEROPAGE_2
		AND ZEROPAGE_2
		ROL ZEROPAGE_2
		PLP
		AND #$22
		ROL
		BIT datablockabs
		AND datablockabs
		ROL datablockabs
		JMP row3
		
row3		BMI row3_target
		AND (ZEROPAGE_3),Y
row3_target	AND (ZEROPAGE_3)
		BIT ZEROPAGE_3,X
		AND ZEROPAGE_3,X
		ROL ZEROPAGE_3,X
		SEC
		AND datablockabs,Y
		DEC
		BIT datablockabs,X
		AND datablockabs,X
		ROL datablockabs,X
		JMP row4

row4		RTI
		EOR (ZEROPAGE_4,X)
		EOR ZEROPAGE_4
		LSR ZEROPAGE_4
		PHA
		EOR #$44
		LSR
		JMP farcode
		EOR datablockabs
		LSR datablockabs
		JMP row5

row5		BVC row5_target
		EOR (ZEROPAGE_5),Y
row5_target	EOR ZEROPAGE_5,X
		LSR ZEROPAGE_5,X
		CLI
		EOR datablockabs,Y
		PHY
		EOR datablockabs,X
		LSR datablockabs,X
		JMP row6

row6		RTS
		ADC (ZEROPAGE_6,X)
		STZ ZEROPAGE_6
		ADC ZEROPAGE_6
		ROR ZEROPAGE_6
		PLA
		ADC #$66
		ROR
		JMP farcode
		ADC datablockabs
		ROR datablockabs
		JMP row7

row7		BVS row7_target
		ADC (ZEROPAGE_7),Y
row7_target	ADC (ZEROPAGE_7)
		STZ ZEROPAGE_7,X
		ADC ZEROPAGE_7,X
		ROR ZEROPAGE_7,X
		SEI
		ADC datablockabs,Y
		PLY
		JMP (datablockabs,X)
		ADC datablockabs,X
		ROR datablockabs,X
		JMP row8

row8		BRA row8_target
		STA (ZEROPAGE_8,X)
row8_target	STY ZEROPAGE_8
		STA ZEROPAGE_8
		STX ZEROPAGE_8
		DEY
		BIT #$88
		TXA
		STY datablockabs
		STA datablockabs
		STX datablockabs
		JMP row9

row9		BCC row9_target
		STA (ZEROPAGE_9),Y
row9_target	STA (ZEROPAGE_9)
		STY ZEROPAGE_9,X
		STA ZEROPAGE_9,X
		STX ZEROPAGE_9,Y
		TYA
		STA datablockabs,Y
		TXS
		STZ datablockabs
		STA datablockabs,X
		STZ datablockabs,X
		JMP rowa

rowa		LDY #$AA
		LDA (ZEROPAGE_A,X)
		LDX #$AA
		LDY ZEROPAGE_A
		LDA ZEROPAGE_A
		LDX ZEROPAGE_A
		TAY
		LDA #$AA
		TAX
		LDY datablockabs
		LDA datablockabs
		LDX datablockabs
		JMP rowb

rowb		BCS rowb_target
		LDA (ZEROPAGE_B),Y
rowb_target	LDA (ZEROPAGE_B)
		LDY ZEROPAGE_B,X
		LDA ZEROPAGE_B,X
		LDX ZEROPAGE_B,Y
		CLV
		LDA datablockabs,Y
		TSX
		LDY datablockabs,X
		LDA datablockabs,X
		LDX datablockabs,Y
		JMP rowc

rowc		CPY #$CC
		CMP (ZEROPAGE_C,X)
		CPY ZEROPAGE_C
		CMP ZEROPAGE_C
		DEC ZEROPAGE_C
		INY
		CMP #$CC
		DEX
		CPY datablockabs
		CMP datablockabs
		DEC datablockabs
		JMP rowd

rowd		BNE rowd_target
		CMP (ZEROPAGE_D),Y
rowd_target	CMP (ZEROPAGE_D)
		CMP ZEROPAGE_D,X
		DEC ZEROPAGE_D,X
		CLD
		CMP datablockabs,Y
		PHX
		CMP datablockabs,X
		DEC datablockabs,X
		JMP rowe

rowe		CPX #$EE
		SBC (ZEROPAGE_E,X)
		CPX ZEROPAGE_E
		SBC ZEROPAGE_E
		INC ZEROPAGE_E
		INX
		SBC #$EE
		NOP
		CPX datablockabs
		SBC datablockabs
		INC datablockabs
		JMP rowf

rowf		BEQ rowf_target
		SBC (ZEROPAGE_F),Y
rowf_target	SBC (ZEROPAGE_F)
		SBC ZEROPAGE_F,X
		INC ZEROPAGE_F,X
		SED
		SBC datablockabs,Y
		PLX
		SBC datablockabs,X
		INC datablockabs,X
		JMP end

end		RTS

datablockabs	.word $1234

farcode		RTI
