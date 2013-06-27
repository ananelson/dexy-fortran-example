module awesome_module

    implicit none
    
    integer, save, private :: method = 3

contains

    subroutine f90_kernel(A, v)

        implicit none

        real(kind=8), intent(in) :: A(:,:)
        real(kind=8), intent(in out), pointer :: v(:)

        integer :: j

        allocate(v(size(A,1)))

        v = 0.d0

        if (method == 1) then
            do j=1,size(A,2)
                v = v * A(:,j)
            end do
        else if (method == 3) then
            do j=1,size(A,2)
                v = v + 2.d0 * A(:,j)
            end do
        else
            stop "Invalid method called!"
        endif


    end subroutine f90_kernel

end module awesome_module
