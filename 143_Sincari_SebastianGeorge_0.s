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
	jjj:.space 4
	kk:.space 4
	ceax:.space 4
	cecx:.space 4
	nrVecini:.space 4
	nr:.space 4
	trash:.space 4
	size:.space 4
	cnt:.space 4
	adrMat:.space 4
	mat:.zero 1600 
	aux:.zero 1600
	dx:.long -1, 0, 1, 0, -1, -1, 1, 1
	dy:.long 0, 1, 0, -1, -1, 1, -1, 1
	auxx:.space 4
	formatIn:.asciz "%d"
	formatOut:.asciz "%d "
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

	movl 8(%ebp),%ecx

	for_golire:
		movl $0,(%esi,%ecx,4)
		loop for_golire
		jmp end_for_golire
	end_for_golire:


	pop %ebp
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

	
	movl $1,i
	for_i_afis:
		movl i,%ecx
		movl m,%ebx
		decl %ebx
		cmp %ecx,%ebx
		je end_for_i_afis

		movl $1,j
		for_j_afis:
			movl j,%ecx
			movl n,%ebx
			decl %ebx
			cmp %ecx,%ebx
			je end_for_j_afis

			xorl %edx,%edx
			movl i,%eax
			mull n
			addl j,%eax
			movl (%edi,%eax,4),%eax

			push %eax
			push $formatOut
			call printf
			pop %ebx
			pop %ebx

			pushl $0
			call fflush
			popl %ebx

			incl j
			jmp for_j_afis
		end_for_j_afis:
			
		movl $4,%eax
		movl $1,%ebx
		movl $newLine,%ecx
		movl $2,%edx
		int $0x80

		incl i
		jmp for_i_afis
	end_for_i_afis:
	
	pushl $0
	call fflush
	popl %ebx

	et_exit:
		movl $1,%eax
		movl $0,%ebx
		int $0x80
