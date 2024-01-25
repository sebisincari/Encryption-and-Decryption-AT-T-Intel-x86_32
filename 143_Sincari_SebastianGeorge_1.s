.data
	n:.space 4
	m:.space 4
	p:.space 4
	k:.space 4
	lin:.space 4
	col:.space 4
	linn:.space 4
	coll:.space 4
	i:.space 4
	j:.space 4
	ii:.space 4
	jj:.space 4
	iii:.space 4
	iiii:.space 4
	jjj:.space 4
	kk:.space 4
	ceax:.space 4
	cecx:.space 4
	nrVecini:.space 4
	nr:.space 4
	trash:.space 4
	size:.space 4
	cnt:.space 4
	cnt1:.space 4
	cntt:.space 4
	cntt1:.space 4
	cnt2:.space 4
	dx:.long -1, 0, 1, 0, -1, -1, 1, 1
	dy:.long 0, 1, 0, -1, -1, 1, -1, 1
	auxx:.space 4
	ch:.space 4
	chh:.space 4
	len:.space 4
	adrMat:.space 4
	dzero:.long 1
	dunu:.long 2
	ddoi:.long 4
	dtrei:.long 8 
	index:.space 4
	index2:.space 4
	sum:.space 4
	nrch:.space 4
	cDecript:.space 4
	pow2:.space 4
	mat:.zero 1600 
	aux:.zero 1600
	mesaj:.zero 1600
	cheie:.zero 1600
	cript:.zero 1600
	str:.zero 40
	formatIn:.asciz "%d"
	formatInStr:.asciz "%s"
	formatOut:.asciz "%d\n"
	formatOutCh:.asciz "%c"
	formatOutHex:.asciz "%X"
	zerox:.asciz "0x"
	newLine:.asciz "\n"

.text
.global main

citire:
	popl %ebp
	push $formatIn
	call scanf
	pop %eax
	pushl %ebp
	ret

swap_matrici:
	push %ebx

     
    movl %edi, %eax      
    movl %esi, %ebx     
    movl %ebx, %edi      
    movl %eax, %esi 

	pop %ebx
	ret

nr_vecini:
	push %ebp
	mov %esp, %ebp
	push %esi
	movl %edi,adrMat
	push %edi
	push %esi

	movl $0, %ecx
	movl 8(%ebp),%eax
	movl %eax,jj
	movl 12(%ebp),%eax
	movl %eax,ii
	movl $0, nr
	
	for_vecini:
		cmp $8, %ecx
		je end_for_vecini

		xor %esi,%esi
		xor %edi,%edi
		lea dx,%esi
		lea dy,%edi
		movl ii,%eax
		addl (%esi,%ecx,4),%eax
		movl %eax,iii
		movl jj,%eax
		addl (%edi,%ecx,4),%eax
		movl %eax,jjj
		xorl %edx,%edx
		movl iii,%eax
		mull n
		addl jjj,%eax
		movl adrMat,%esi
		movl (%esi,%eax,4),%eax

		cmp $1, %eax
		jne else_vecin
			incl nr
		else_vecin:
		incl %ecx	
		jmp for_vecini
	end_for_vecini:
	
	movl nr,%eax
	pop %esi
	pop %edi
	pop %esi
	pop %ebp
	ret

golire_mem:
	push %ebp
	mov %esp,%ebp
	//push %esi

	movl 8(%ebp),%ecx
	//lea aux,%esi

	for_golire:
		movl $0,(%esi,%ecx,4)
		loop for_golire
		jmp end_for_golire
	end_for_golire:

	//pop %esi
	pop %ebp
	ret

construct_mesaj:
	push %edi
	push %esi
	push %ebx

	lea str,%edi
	push %edi
	push $formatInStr
	call scanf
	pop %ebx
	pop %ebx

	lea mesaj,%edi
	lea str,%esi
	movl $0,iiii
    movl $1,chh
    for_str:
        mov chh,%eax
        cmp $0,%eax
        je end_for_str
        
		xorl %ebx,%ebx
		movl iiii,%ecx
		movl (%esi,%ecx,1),%ebx
		
        mov %ebx,ch
        mov %ebx,chh

        movl $7,%ecx
        while_caracter:

            mov ch,%ebx
            cmp $0,%ebx
            je end_for_str
            and $1,%ebx
            movl iiii,%eax
            movl $8,%edx
            mull %edx
            add %ecx,%eax
            movl %ebx,(%edi,%eax,4)
            mov ch,%eax
            shr $1,%eax
            movl %eax,ch
            
            loop while_caracter
            jmp end_while_caracter
        end_while_caracter:
        incl iiii
        jmp for_str
    end_for_str:

	movl iiii,%eax
	movl $8,%ecx
	mull %ecx

	pop %ebx
	pop %esi
	pop %edi
	ret


construct_cheie:

	//mesaj mai lung decat cheia
	//lea cheie,%edi
	//lea mat,%esi
	er:
	movl $0,cntt
	movl $0,cntt1
	for_cheie:
		movl cntt,%ecx
		cmp len,%ecx
		je end_for_cheie

		movl cntt1,%ecx
		cmp size,%ecx
		jne cont_if_mod
			movl $0,cntt1
		cont_if_mod:

		movl cntt1,%ecx
		movl (%esi,%ecx,4),%eax
		movl cntt,%ecx
		movl %eax,(%edi,%ecx,4)
	
		//push %eax
		//push $formatOut
		//call printf
		//pop %ebx
		//pop %ebx


		incl cntt
		incl cntt1
		jmp for_cheie
	end_for_cheie:

	ret

construct_cript:

	movl $0,cnt1
	for_cript:
		movl cnt1,%ecx
		cmp len,%ecx
		je end_for_cript

		movl (%esi,%ecx,4),%eax
		movl (%edi,%ecx,4),%edx
		xor %eax,%edx
		movl %edx,(%esi,%ecx,4)

		incl cnt1
		jmp for_cript
	end_for_cript:

	ret

afisare_hexa:
	push %ebp
	mov %esp,%ebp
	push %edi

	lea cheie,%edi
	movl 8(%ebp),%ecx
	movl $0,sum

	movl (%edi,%ecx,4),%eax
	mull dtrei
	addl %eax,sum
	incl %ecx

	movl (%edi,%ecx,4),%eax
	mull ddoi
	addl %eax,sum
	incl %ecx

	movl (%edi,%ecx,4),%eax
	mull dunu
	addl %eax,sum
	incl %ecx

	movl (%edi,%ecx,4),%eax
	mull dzero
	addl %eax,sum

	push sum
	push $formatOutHex
	call printf
	pop %edx
	pop %edx

	pushl $0
	call fflush
	popl %ebx

	pop %edi
	pop %ebp
	ret

construct_binar:

	lea str,%esi
	push %esi
	push $formatInStr
	call scanf
	pop %ebx
	pop %ebx

	lea cript,%edi

	movl $0,iiii
	movl $2,nrch
    movl $1,chh
    for_stri:
        mov chh,%eax
        cmp $0,%eax
        je end_for_stri
        
		xorl %ebx,%ebx
		movl nrch,%ecx
		movb (%esi,%ecx,1),%bl
		mov %ebx,chh
		cmp $60,%ebx
		jl cifra
		litera:
			movl $55,%eax
			sub %eax,%ebx
			jmp contin
		cifra:
			movl $48,%eax
			sub %eax,%ebx
		contin:

        mov %ebx,ch
        
		cmp $-48,%ebx
		je end_for_stri

		//push %ebx
		//push $formatOut
		//call printf
		//pop %edx
		//pop %edx

        movl $4,%ecx
		movl $3,cecx
        while_caractere:

            mov ch,%ebx
            and $1,%ebx
            movl iiii,%eax
            movl $4,%edx
            mull %edx
            add cecx,%eax
            movl %ebx,(%edi,%eax,4)
            mov ch,%eax
            shr $1,%eax
            movl %eax,ch
            
			decl cecx
            loop while_caractere
            jmp end_while_caractere
        end_while_caractere:
        incl iiii
		incl nrch
        jmp for_stri
    end_for_stri:

	movl iiii,%eax
	movl $4,%ecx
	mull %ecx
	
	ret


revert_cript:
	movl $0,cnt1
	for_cript_r:
		movl cnt1,%ecx
		cmp len,%ecx
		je end_for_cript_r

		movl (%esi,%ecx,4),%eax
		movl (%edi,%ecx,4),%edx
		xor %eax,%edx
		movl %edx,(%esi,%ecx,4)

		incl cnt1
		jmp for_cript_r
	end_for_cript_r:

	ret


afisare_clar:
	movl $0,sum
	movl $0,index2

	//len/8
	xorl %edx,%edx
	movl len,%eax
	movl $8,%ebx
	divl %ebx
	movl %eax,len
	
	for_afis_clar:
		movl index2, %ecx
		cmp len,%ecx
		je end_for_afis_clar
		movl $0,sum

		movl $1,%eax
		movl $1,pow2
		movl $7,cnt2
		for_litera:
			movl cnt2,%ecx
			cmp $-1,%ecx
			je end_for_litera

			movl $8,%eax
			movl index2,%ecx
			mull %ecx
			addl cnt2,%eax
			movl %eax,%ecx
			movl pow2,%eax
			movl (%esi,%ecx,4),%ebx
			mull %ebx
			addl %eax,sum

		

			movl pow2,%eax
			movl $2,%ebx
			mull %ebx
			movl %eax,pow2
			decl cnt2
			jmp for_litera
		end_for_litera:

		push sum
		push $formatOutCh
		call printf
		pop %edx
		pop %edx

		incl index2
		jmp for_afis_clar
	end_for_afis_clar:

	//push $newLine
	//call printf
	//pop %edx

	pushl $0
	call fflush
	popl %ebx
	ret


main:
	citire_m:
		push $m
		call citire
		pop %ebx

	citire_n:
		push $n
		call citire
		pop %ebx
		
	citire_p:
		push $p
		call citire
		pop %ebx

		incl m
		incl m
		incl n
		incl n
		movl $0,i
	for_citire:	
		movl i,%ecx
		cmp %ecx,p
		je end_for
		
		pushl $lin
		call citire
		popl %ebx
		
		pushl $col
		call citire
		popl %ebx
		
		incl lin
		incl col

		//lin*n+col
		xorl %edx,%edx
		movl lin,%eax
		mull n
		addl col,%eax

		lea mat,%edi
		movl $1,(%edi,%eax,4)
		incl i
		jmp for_citire
	end_for:
	
	citire_k:
		push $kk
		call citire
		pop %ebx
		lea mat,%edi
		lea aux,%esi
	movl $0,cnt
	for_generatii:
		movl cnt,%ebx
		cmp %ebx,kk
		je end_for_generatii


		movl $1,i
		
		for_i:
			movl i,%ecx
			movl m,%ebx
			decl %ebx
			cmp %ecx,%ebx
			je end_for_i
			movl $1,j
			for_j:
				movl j,%ecx
				movl n,%ebx
				decl %ebx
				cmp %ecx,%ebx
				je end_for_j
				
				xorl %edx,%edx
				movl i,%eax
				mull n
				addl j,%eax
				movl %eax,cecx
				
				pushl i
				pushl j		
				call nr_vecini	
				popl %ebx
				popl %ebx
		
				movl cecx,%ecx

				if:
						movl (%edi,%ecx,4),%ebx
						cmp $0,%ebx
						je moarta
						cmp $1,%ebx
						je vie
					vie:
						cmp $2,%eax
						jl zero
						cmp $3, %eax
						jg zero
						movl $1,(%esi,%ecx,4)
						jmp end_if
						zero:
							movl $0,(%esi,%ecx,4)
							jmp end_if
					jmp end_if
					moarta:
						cmp $3,%eax
						je unu
						movl $0,(%esi,%ecx,4)
						jmp end_if
						unu:
							movl $1,(%esi,%ecx,4)
				end_if:

				incl j
				jmp for_j
			end_for_j:
			
			incl i
			jmp for_i
		end_for_i:
			
		call swap_matrici

		movl $1,size
		xorl %edx,%edx
		movl size,%eax
		mull n
		mull m

		movl %eax,size

		incl cnt
		jmp for_generatii
	end_for_generatii:

	citire_cDec:
		push $cDecript
		call citire
		pop %ebx

	movl cDecript,%edx
	cmp $0,%edx
	jne decriptare

	criptare:
	
	movl %edi, adrMat
	
	movl $1,size
	xorl %edx,%edx
	movl size,%eax
	mull n
	mull m
	movl %eax,size
	
	lea mesaj,%edi
	call construct_mesaj
	movl %eax,len
	
	lea cheie,%edi
	movl adrMat,%esi
	call construct_cheie
	
	lea mesaj,%edi
	lea cheie,%esi
	call construct_cript
	
	push $zerox
	call printf
	pop %ebx

	movl $0,%ecx
	for_afis_hex:
		cmp len,%ecx
		jge end_for_afis_hex

		pushl %ecx
		call afisare_hexa
		pop %ecx

		addl $4,%ecx
		jmp for_afis_hex
	end_for_afis_hex:
	
	push $newLine
	call printf
	pop %ebx
	jmp et_exit

	decriptare:
	
	movl %edi, adrMat

	lea cheie,%edi
	movl adrMat,%esi
	call construct_binar
	movl %eax,len


	lea cheie,%edi
	movl adrMat,%esi
	call construct_cheie

	//rez ramane in esi
	lea cheie,%esi
	lea cript,%edi
	call revert_cript

	call afisare_clar

	et_exit:
		movl $1,%eax
		movl $0,%ebx
		int $0x80
