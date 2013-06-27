c ======================================================================
c  Copyright (C) Kyle T. Mandli <kyle@ices.utexas.edu>
c
c  Distributed under the terms of the Berkeley Software Distribution
c  (BSD) license
c                     http://www.opensource.org/licenses/
c ======================================================================

       subroutine f77_kernel(a,b)

       implicit double precision (a-h,o-z)

       b = a * 3.d0

       end