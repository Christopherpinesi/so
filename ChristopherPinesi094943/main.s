	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 10, 15	sdk_version 10, 15, 4
	.globl	_levenshtein_distance   ## -- Begin function levenshtein_distance
	.p2align	4, 0x90
_levenshtein_distance:                  ## @levenshtein_distance
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$80, %rsp
	movq	%rdi, -16(%rbp)
	movq	%rsi, -24(%rbp)
	movq	%rdx, -32(%rbp)
	movq	-16(%rbp), %rdi
	callq	_strlen
	movq	%rax, -40(%rbp)
	movq	-24(%rbp), %rdi
	callq	_strlen
	movq	%rax, -48(%rbp)
	cmpq	$0, -40(%rbp)
	jne	LBB0_2
## %bb.1:
	movq	-48(%rbp), %rax
                                        ## kill: def $eax killed $eax killed $rax
	movl	%eax, -4(%rbp)
	jmp	LBB0_20
LBB0_2:
	cmpq	$0, -48(%rbp)
	jne	LBB0_4
## %bb.3:
	movq	-40(%rbp), %rax
                                        ## kill: def $eax killed $eax killed $rax
	movl	%eax, -4(%rbp)
	jmp	LBB0_20
LBB0_4:
	movq	-16(%rbp), %rdi
	movq	-40(%rbp), %rsi
	movq	-24(%rbp), %rdx
	movq	-48(%rbp), %rcx
	callq	_levenshtein_matrix_create
	movq	%rax, -64(%rbp)
	cmpq	$0, -64(%rbp)
	jne	LBB0_6
## %bb.5:
	movq	-32(%rbp), %rax
	movq	$0, (%rax)
	movl	$0, -4(%rbp)
	jmp	LBB0_20
LBB0_6:
	movq	-64(%rbp), %rdi
	movq	-16(%rbp), %rsi
	movq	-40(%rbp), %rdx
	movq	-24(%rbp), %rcx
	movq	-48(%rbp), %r8
	callq	_levenshtein_matrix_calculate
	movl	%eax, -56(%rbp)
	movl	-56(%rbp), %eax
	movl	%eax, %ecx
	imulq	$24, %rcx, %rdi
	callq	_malloc
	movq	-32(%rbp), %rcx
	movq	%rax, (%rcx)
	movq	-32(%rbp), %rax
	cmpq	$0, (%rax)
	je	LBB0_14
## %bb.7:
	movl	-56(%rbp), %eax
	subl	$1, %eax
	movl	%eax, -52(%rbp)
	movq	-64(%rbp), %rcx
	movq	-40(%rbp), %rdx
	movq	(%rcx,%rdx,8), %rcx
	imulq	$24, -48(%rbp), %rdx
	addq	%rdx, %rcx
	movq	%rcx, -72(%rbp)
LBB0_8:                                 ## =>This Inner Loop Header: Depth=1
	movq	-72(%rbp), %rax
	cmpq	$0, 16(%rax)
	je	LBB0_13
## %bb.9:                               ##   in Loop: Header=BB0_8 Depth=1
	movq	-72(%rbp), %rax
	cmpl	$3, 4(%rax)
	je	LBB0_11
## %bb.10:                              ##   in Loop: Header=BB0_8 Depth=1
	movq	$-1, %rcx
	movq	-32(%rbp), %rax
	movq	(%rax), %rax
	movl	-52(%rbp), %edx
	movl	%edx, %esi
	imulq	$24, %rsi, %rsi
	addq	%rsi, %rax
	movq	-72(%rbp), %rsi
	movq	%rax, %rdi
	movl	$24, %edx
	callq	___memcpy_chk
	movl	-52(%rbp), %r8d
	addl	$-1, %r8d
	movl	%r8d, -52(%rbp)
LBB0_11:                                ##   in Loop: Header=BB0_8 Depth=1
	jmp	LBB0_12
LBB0_12:                                ##   in Loop: Header=BB0_8 Depth=1
	movq	-72(%rbp), %rax
	movq	16(%rax), %rax
	movq	%rax, -72(%rbp)
	jmp	LBB0_8
LBB0_13:
	jmp	LBB0_15
LBB0_14:
	movl	$0, -56(%rbp)
LBB0_15:
	movl	$0, -52(%rbp)
LBB0_16:                                ## =>This Inner Loop Header: Depth=1
	movl	-52(%rbp), %eax
	movl	%eax, %ecx
	cmpq	-40(%rbp), %rcx
	ja	LBB0_19
## %bb.17:                              ##   in Loop: Header=BB0_16 Depth=1
	movq	-64(%rbp), %rax
	movl	-52(%rbp), %ecx
	movl	%ecx, %edx
	movq	(%rax,%rdx,8), %rax
	movq	%rax, %rdi
	callq	_free
## %bb.18:                              ##   in Loop: Header=BB0_16 Depth=1
	movl	-52(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -52(%rbp)
	jmp	LBB0_16
LBB0_19:
	movq	-64(%rbp), %rax
	movq	%rax, %rdi
	callq	_free
	movl	-56(%rbp), %ecx
	movl	%ecx, -4(%rbp)
LBB0_20:
	movl	-4(%rbp), %eax
	addq	$80, %rsp
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.p2align	4, 0x90         ## -- Begin function levenshtein_matrix_create
_levenshtein_matrix_create:             ## @levenshtein_matrix_create
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$64, %rsp
	movq	%rdi, -16(%rbp)
	movq	%rsi, -24(%rbp)
	movq	%rdx, -32(%rbp)
	movq	%rcx, -40(%rbp)
	movq	-24(%rbp), %rax
	addq	$1, %rax
	shlq	$3, %rax
	movq	%rax, %rdi
	callq	_malloc
	movq	%rax, -56(%rbp)
	cmpq	$0, -56(%rbp)
	jne	LBB1_2
## %bb.1:
	movq	$0, -8(%rbp)
	jmp	LBB1_21
LBB1_2:
	movl	$0, -44(%rbp)
LBB1_3:                                 ## =>This Inner Loop Header: Depth=1
	movl	-44(%rbp), %eax
	movl	%eax, %ecx
	cmpq	-24(%rbp), %rcx
	ja	LBB1_12
## %bb.4:                               ##   in Loop: Header=BB1_3 Depth=1
	movq	-40(%rbp), %rax
	addq	$1, %rax
	imulq	$24, %rax, %rdi
	callq	_malloc
	movq	-56(%rbp), %rcx
	movl	-44(%rbp), %edx
	movl	%edx, %esi
	movq	%rax, (%rcx,%rsi,8)
	movq	-56(%rbp), %rax
	movl	-44(%rbp), %edx
	movl	%edx, %ecx
	cmpq	$0, (%rax,%rcx,8)
	jne	LBB1_10
## %bb.5:
	movl	$0, -48(%rbp)
LBB1_6:                                 ## =>This Inner Loop Header: Depth=1
	movl	-48(%rbp), %eax
	cmpl	-44(%rbp), %eax
	jae	LBB1_9
## %bb.7:                               ##   in Loop: Header=BB1_6 Depth=1
	movq	-56(%rbp), %rax
	movl	-48(%rbp), %ecx
	movl	%ecx, %edx
	movq	(%rax,%rdx,8), %rax
	movq	%rax, %rdi
	callq	_free
## %bb.8:                               ##   in Loop: Header=BB1_6 Depth=1
	movl	-48(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -48(%rbp)
	jmp	LBB1_6
LBB1_9:
	movq	-56(%rbp), %rax
	movq	%rax, %rdi
	callq	_free
	movq	$0, -8(%rbp)
	jmp	LBB1_21
LBB1_10:                                ##   in Loop: Header=BB1_3 Depth=1
	jmp	LBB1_11
LBB1_11:                                ##   in Loop: Header=BB1_3 Depth=1
	movl	-44(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -44(%rbp)
	jmp	LBB1_3
LBB1_12:
	movl	$0, -44(%rbp)
LBB1_13:                                ## =>This Inner Loop Header: Depth=1
	movl	-44(%rbp), %eax
	movl	%eax, %ecx
	cmpq	-24(%rbp), %rcx
	ja	LBB1_16
## %bb.14:                              ##   in Loop: Header=BB1_13 Depth=1
	movl	-44(%rbp), %eax
	movq	-56(%rbp), %rcx
	movl	-44(%rbp), %edx
	movl	%edx, %esi
	movq	(%rcx,%rsi,8), %rcx
	movl	%eax, (%rcx)
	movq	-56(%rbp), %rcx
	movl	-44(%rbp), %eax
	movl	%eax, %esi
	movq	(%rcx,%rsi,8), %rcx
	movq	$0, 16(%rcx)
	movq	-56(%rbp), %rcx
	movl	-44(%rbp), %eax
	movl	%eax, %esi
	movq	(%rcx,%rsi,8), %rcx
	movb	$0, 8(%rcx)
	movq	-56(%rbp), %rcx
	movl	-44(%rbp), %eax
	movl	%eax, %esi
	movq	(%rcx,%rsi,8), %rcx
	movb	$0, 9(%rcx)
## %bb.15:                              ##   in Loop: Header=BB1_13 Depth=1
	movl	-44(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -44(%rbp)
	jmp	LBB1_13
LBB1_16:
	movl	$0, -48(%rbp)
LBB1_17:                                ## =>This Inner Loop Header: Depth=1
	movl	-48(%rbp), %eax
	movl	%eax, %ecx
	cmpq	-40(%rbp), %rcx
	ja	LBB1_20
## %bb.18:                              ##   in Loop: Header=BB1_17 Depth=1
	movl	-48(%rbp), %eax
	movq	-56(%rbp), %rcx
	movq	(%rcx), %rcx
	movl	-48(%rbp), %edx
	movl	%edx, %esi
	imulq	$24, %rsi, %rsi
	addq	%rsi, %rcx
	movl	%eax, (%rcx)
	movq	-56(%rbp), %rcx
	movq	(%rcx), %rcx
	movl	-48(%rbp), %eax
	movl	%eax, %esi
	imulq	$24, %rsi, %rsi
	addq	%rsi, %rcx
	movq	$0, 16(%rcx)
	movq	-56(%rbp), %rcx
	movq	(%rcx), %rcx
	movl	-48(%rbp), %eax
	movl	%eax, %esi
	imulq	$24, %rsi, %rsi
	addq	%rsi, %rcx
	movb	$0, 8(%rcx)
	movq	-56(%rbp), %rcx
	movq	(%rcx), %rcx
	movl	-48(%rbp), %eax
	movl	%eax, %esi
	imulq	$24, %rsi, %rsi
	addq	%rsi, %rcx
	movb	$0, 9(%rcx)
## %bb.19:                              ##   in Loop: Header=BB1_17 Depth=1
	movl	-48(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -48(%rbp)
	jmp	LBB1_17
LBB1_20:
	movq	-56(%rbp), %rax
	movq	%rax, -8(%rbp)
LBB1_21:
	movq	-8(%rbp), %rax
	addq	$64, %rsp
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.p2align	4, 0x90         ## -- Begin function levenshtein_matrix_calculate
_levenshtein_matrix_calculate:          ## @levenshtein_matrix_calculate
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$80, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -24(%rbp)
	movq	%rcx, -32(%rbp)
	movq	%r8, -40(%rbp)
	movl	$1, -48(%rbp)
LBB2_1:                                 ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB2_3 Depth 2
	movl	-48(%rbp), %eax
	movl	%eax, %ecx
	cmpq	-40(%rbp), %rcx
	ja	LBB2_20
## %bb.2:                               ##   in Loop: Header=BB2_1 Depth=1
	movl	$1, -44(%rbp)
LBB2_3:                                 ##   Parent Loop BB2_1 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	movl	-44(%rbp), %eax
	movl	%eax, %ecx
	cmpq	-24(%rbp), %rcx
	ja	LBB2_18
## %bb.4:                               ##   in Loop: Header=BB2_3 Depth=2
	movl	$0, -56(%rbp)
	movl	$0, -60(%rbp)
	movl	$0, -64(%rbp)
	movq	-16(%rbp), %rax
	movl	-44(%rbp), %ecx
	subl	$1, %ecx
	movl	%ecx, %ecx
	movl	%ecx, %edx
	movsbl	(%rax,%rdx), %ecx
	movq	-32(%rbp), %rax
	movl	-48(%rbp), %esi
	subl	$1, %esi
	movl	%esi, %esi
	movl	%esi, %edx
	movsbl	(%rax,%rdx), %esi
	cmpl	%esi, %ecx
	jne	LBB2_6
## %bb.5:                               ##   in Loop: Header=BB2_3 Depth=2
	movl	$0, -52(%rbp)
	jmp	LBB2_7
LBB2_6:                                 ##   in Loop: Header=BB2_3 Depth=2
	movl	$1, -52(%rbp)
LBB2_7:                                 ##   in Loop: Header=BB2_3 Depth=2
	movq	-8(%rbp), %rax
	movl	-44(%rbp), %ecx
	subl	$1, %ecx
	movl	%ecx, %ecx
	movl	%ecx, %edx
	movq	(%rax,%rdx,8), %rax
	movl	-48(%rbp), %ecx
	movl	%ecx, %edx
	imulq	$24, %rdx, %rdx
	addq	%rdx, %rax
	movl	(%rax), %ecx
	addl	$1, %ecx
	movl	%ecx, -56(%rbp)
	movq	-8(%rbp), %rax
	movl	-44(%rbp), %ecx
	movl	%ecx, %edx
	movq	(%rax,%rdx,8), %rax
	movl	-48(%rbp), %ecx
	subl	$1, %ecx
	movl	%ecx, %ecx
	movl	%ecx, %edx
	imulq	$24, %rdx, %rdx
	addq	%rdx, %rax
	movl	(%rax), %ecx
	addl	$1, %ecx
	movl	%ecx, -60(%rbp)
	movq	-8(%rbp), %rax
	movl	-44(%rbp), %ecx
	subl	$1, %ecx
	movl	%ecx, %ecx
	movl	%ecx, %edx
	movq	(%rax,%rdx,8), %rax
	movl	-48(%rbp), %ecx
	subl	$1, %ecx
	movl	%ecx, %ecx
	movl	%ecx, %edx
	imulq	$24, %rdx, %rdx
	addq	%rdx, %rax
	movl	(%rax), %ecx
	addl	-52(%rbp), %ecx
	movl	%ecx, -64(%rbp)
	movl	-56(%rbp), %edi
	movl	-60(%rbp), %esi
	movl	-64(%rbp), %edx
	callq	_min3
	movl	%eax, -68(%rbp)
	movl	-68(%rbp), %eax
	movq	-8(%rbp), %r8
	movl	-44(%rbp), %ecx
	movl	%ecx, %r9d
	movq	(%r8,%r9,8), %r8
	movl	-48(%rbp), %ecx
	movl	%ecx, %r9d
	imulq	$24, %r9, %r9
	addq	%r9, %r8
	movl	%eax, (%r8)
	movq	-16(%rbp), %r8
	movl	-44(%rbp), %eax
	subl	$1, %eax
	movl	%eax, %eax
	movl	%eax, %r9d
	movb	(%r8,%r9), %r10b
	movq	-8(%rbp), %r8
	movl	-44(%rbp), %eax
	movl	%eax, %r9d
	movq	(%r8,%r9,8), %r8
	movl	-48(%rbp), %eax
	movl	%eax, %r9d
	imulq	$24, %r9, %r9
	addq	%r9, %r8
	movb	%r10b, 8(%r8)
	movq	-32(%rbp), %r8
	movl	-48(%rbp), %eax
	subl	$1, %eax
	movl	%eax, %eax
	movl	%eax, %r9d
	movb	(%r8,%r9), %r10b
	movq	-8(%rbp), %r8
	movl	-44(%rbp), %eax
	movl	%eax, %r9d
	movq	(%r8,%r9,8), %r8
	movl	-48(%rbp), %eax
	movl	%eax, %r9d
	imulq	$24, %r9, %r9
	addq	%r9, %r8
	movb	%r10b, 9(%r8)
	movl	-44(%rbp), %eax
	subl	$1, %eax
	movq	-8(%rbp), %r8
	movl	-44(%rbp), %ecx
	movl	%ecx, %r9d
	movq	(%r8,%r9,8), %r8
	movl	-48(%rbp), %ecx
	movl	%ecx, %r9d
	imulq	$24, %r9, %r9
	addq	%r9, %r8
	movl	%eax, 12(%r8)
	movl	-68(%rbp), %eax
	cmpl	-56(%rbp), %eax
	jne	LBB2_9
## %bb.8:                               ##   in Loop: Header=BB2_3 Depth=2
	movq	-8(%rbp), %rax
	movl	-44(%rbp), %ecx
	movl	%ecx, %edx
	movq	(%rax,%rdx,8), %rax
	movl	-48(%rbp), %ecx
	movl	%ecx, %edx
	imulq	$24, %rdx, %rdx
	addq	%rdx, %rax
	movl	$1, 4(%rax)
	movq	-8(%rbp), %rax
	movl	-44(%rbp), %ecx
	subl	$1, %ecx
	movl	%ecx, %ecx
	movl	%ecx, %edx
	movq	(%rax,%rdx,8), %rax
	movl	-48(%rbp), %ecx
	movl	%ecx, %edx
	imulq	$24, %rdx, %rdx
	addq	%rdx, %rax
	movq	-8(%rbp), %rdx
	movl	-44(%rbp), %ecx
	movl	%ecx, %esi
	movq	(%rdx,%rsi,8), %rdx
	movl	-48(%rbp), %ecx
	movl	%ecx, %esi
	imulq	$24, %rsi, %rsi
	addq	%rsi, %rdx
	movq	%rax, 16(%rdx)
	jmp	LBB2_16
LBB2_9:                                 ##   in Loop: Header=BB2_3 Depth=2
	movl	-68(%rbp), %eax
	cmpl	-60(%rbp), %eax
	jne	LBB2_11
## %bb.10:                              ##   in Loop: Header=BB2_3 Depth=2
	movq	-8(%rbp), %rax
	movl	-44(%rbp), %ecx
	movl	%ecx, %edx
	movq	(%rax,%rdx,8), %rax
	movl	-48(%rbp), %ecx
	movl	%ecx, %edx
	imulq	$24, %rdx, %rdx
	addq	%rdx, %rax
	movl	$0, 4(%rax)
	movq	-8(%rbp), %rax
	movl	-44(%rbp), %ecx
	movl	%ecx, %edx
	movq	(%rax,%rdx,8), %rax
	movl	-48(%rbp), %ecx
	subl	$1, %ecx
	movl	%ecx, %ecx
	movl	%ecx, %edx
	imulq	$24, %rdx, %rdx
	addq	%rdx, %rax
	movq	-8(%rbp), %rdx
	movl	-44(%rbp), %ecx
	movl	%ecx, %esi
	movq	(%rdx,%rsi,8), %rdx
	movl	-48(%rbp), %ecx
	movl	%ecx, %esi
	imulq	$24, %rsi, %rsi
	addq	%rsi, %rdx
	movq	%rax, 16(%rdx)
	jmp	LBB2_15
LBB2_11:                                ##   in Loop: Header=BB2_3 Depth=2
	cmpl	$0, -52(%rbp)
	jbe	LBB2_13
## %bb.12:                              ##   in Loop: Header=BB2_3 Depth=2
	movq	-8(%rbp), %rax
	movl	-44(%rbp), %ecx
	movl	%ecx, %edx
	movq	(%rax,%rdx,8), %rax
	movl	-48(%rbp), %ecx
	movl	%ecx, %edx
	imulq	$24, %rdx, %rdx
	addq	%rdx, %rax
	movl	$2, 4(%rax)
	jmp	LBB2_14
LBB2_13:                                ##   in Loop: Header=BB2_3 Depth=2
	movq	-8(%rbp), %rax
	movl	-44(%rbp), %ecx
	movl	%ecx, %edx
	movq	(%rax,%rdx,8), %rax
	movl	-48(%rbp), %ecx
	movl	%ecx, %edx
	imulq	$24, %rdx, %rdx
	addq	%rdx, %rax
	movl	$3, 4(%rax)
LBB2_14:                                ##   in Loop: Header=BB2_3 Depth=2
	movq	-8(%rbp), %rax
	movl	-44(%rbp), %ecx
	subl	$1, %ecx
	movl	%ecx, %ecx
	movl	%ecx, %edx
	movq	(%rax,%rdx,8), %rax
	movl	-48(%rbp), %ecx
	subl	$1, %ecx
	movl	%ecx, %ecx
	movl	%ecx, %edx
	imulq	$24, %rdx, %rdx
	addq	%rdx, %rax
	movq	-8(%rbp), %rdx
	movl	-44(%rbp), %ecx
	movl	%ecx, %esi
	movq	(%rdx,%rsi,8), %rdx
	movl	-48(%rbp), %ecx
	movl	%ecx, %esi
	imulq	$24, %rsi, %rsi
	addq	%rsi, %rdx
	movq	%rax, 16(%rdx)
LBB2_15:                                ##   in Loop: Header=BB2_3 Depth=2
	jmp	LBB2_16
LBB2_16:                                ##   in Loop: Header=BB2_3 Depth=2
	jmp	LBB2_17
LBB2_17:                                ##   in Loop: Header=BB2_3 Depth=2
	movl	-44(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -44(%rbp)
	jmp	LBB2_3
LBB2_18:                                ##   in Loop: Header=BB2_1 Depth=1
	jmp	LBB2_19
LBB2_19:                                ##   in Loop: Header=BB2_1 Depth=1
	movl	-48(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -48(%rbp)
	jmp	LBB2_1
LBB2_20:
	movq	-8(%rbp), %rax
	movq	-24(%rbp), %rcx
	movq	(%rax,%rcx,8), %rax
	imulq	$24, -40(%rbp), %rcx
	addq	%rcx, %rax
	movl	(%rax), %eax
	addq	$80, %rsp
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.p2align	4, 0x90         ## -- Begin function min3
_min3:                                  ## @min3
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movl	%edi, -8(%rbp)
	movl	%esi, -12(%rbp)
	movl	%edx, -16(%rbp)
	movl	-8(%rbp), %eax
	cmpl	-12(%rbp), %eax
	jge	LBB3_3
## %bb.1:
	movl	-8(%rbp), %eax
	cmpl	-16(%rbp), %eax
	jge	LBB3_3
## %bb.2:
	movl	-8(%rbp), %eax
	movl	%eax, -4(%rbp)
	jmp	LBB3_7
LBB3_3:
	movl	-12(%rbp), %eax
	cmpl	-8(%rbp), %eax
	jge	LBB3_6
## %bb.4:
	movl	-12(%rbp), %eax
	cmpl	-16(%rbp), %eax
	jge	LBB3_6
## %bb.5:
	movl	-12(%rbp), %eax
	movl	%eax, -4(%rbp)
	jmp	LBB3_7
LBB3_6:
	movl	-16(%rbp), %eax
	movl	%eax, -4(%rbp)
LBB3_7:
	movl	-4(%rbp), %eax
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function

.subsections_via_symbols
