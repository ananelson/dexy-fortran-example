! ==============================================================================
!          Copyright (C) Kyle T. Mandli <kyle@ices.utexas.edu>
!
!  Distributed under the terms of the Berkeley Software Distribution (BSD) 
!  license
!                     http://www.opensource.org/licenses/
! ==============================================================================

program DexyExample

    use awesome_module, only: f90_kernel
    use other_module

    implicit none
    
    real(kind=8), allocatable :: A(:,:)
    real(kind=8), pointer :: v(:), b(:)

    real(kind=8) :: temp

    integer :: i, j

    allocate(A(N(1), N(2)), b(N(1)))

    A = 1.d0

    print *,"Matrix A ="
    call display_matrix(A)
    b = 0.d0

    do i=1,size(A,1)
        do j=1,size(A,2)
            call f77_kernel(A(i,j), temp)
            b(i) = b(i) + temp
        end do   
    end do
    print *, "Vector b = "
    call display_vector(b)

    call f90_kernel(A,v)

    print *, "Vector v = "
    call display_vector(v)

    deallocate(A, v, b)

contains

    subroutine display_matrix(A)
        
        real(kind=8), intent(in) :: A(:,:)

        integer :: i, j

        do j=1, size(A,2)
            print *, (A(i,j), i=1,size(A,1))
        end do
        
    end subroutine display_matrix

    subroutine display_vector(b)
        
        real(kind=8), intent(in) :: b(:)

        integer :: i

        print *, (b(i), i=1,size(b,1))
        
    end subroutine display_vector


end program DexyExample
