module readers_mod
implicit none
contains
! call read_parameters("parameters.nml", dt, N, n_steps, n_save_pos, L,&
! simulation_name, temperature, epsilon, cutoff, nu)
subroutine read_parameters(param_file, dt, n_particles, n_steps, n_save_pos, L,&
    simulation_name, temperature,epsilon,cutoff,vcutoff,nu)
    implicit none
    ! Subroutine to read the simulation parameters from a an nml list
    !
    ! INPUT:
    !   param_file : The path of the parameter file 

    character(len=*), intent(in)        :: param_file
    real*8, intent(inout)               :: dt, temperature, L, cutoff,vcutoff,epsilon,nu
    integer, intent(inout)              :: n_particles, n_steps, n_save_pos
    character(len=500), intent(inout)   :: simulation_name

    integer                              :: unit_nr, iost
    character(len=1024)                  :: msg
    ! Namelist variables

    namelist /PARAMS/ n_steps, n_save_pos, dt, n_particles, L, temperature,&
    epsilon,cutoff,vcutoff,nu,simulation_name

    ! Reading namelist
    open(newunit=unit_nr, file=trim(param_file), access='sequential', &
    action='read', iostat=iost, iomsg=msg, form='formatted')

    read(iostat=iost, unit=unit_nr, nml=PARAMS, iomsg=msg)
    if (iost /= 0) then
        write(*, fmt='(A)') trim(msg)
        stop 1
    end if
    close(unit_nr)

end subroutine read_parameters


end module readers_mod
