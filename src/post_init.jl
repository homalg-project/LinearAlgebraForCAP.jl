# IsZero/IsOne: install the functions in MatricesForHomalg as methods for the attributes defined in CAP
@InstallMethod( IsZero, [ IsHomalgMatrix ], M -> MatricesForHomalg.IsZero( M ) );
@InstallMethod( IsOne, [ IsHomalgMatrix ], M -> MatricesForHomalg.IsOne( M ) );
@InstallMethod( IsZero, [ IsHomalgRingElement ], e -> MatricesForHomalg.IsZero( e ) );
@InstallMethod( StringGAP, [ IsHomalgRing ], RingName );
@InstallMethod( ViewString, [ IsHomalgRingElement ], StringDisplay );
