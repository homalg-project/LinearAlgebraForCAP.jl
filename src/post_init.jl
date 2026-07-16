# IsZero/IsOne: install the functions in MatricesForHomalg as methods for the attributes defined in CAP
@InstallMethod( IsZero, [ IsHomalgMatrix ], M -> MatricesForHomalg.IsZero( M ) );
@InstallMethod( IsOne, [ IsHomalgMatrix ], M -> MatricesForHomalg.IsOne( M ) );
@InstallMethod( IsZero, [ IsHomalgRingElement ], e -> MatricesForHomalg.IsZero( e ) );
@InstallMethod( StringGAP, [ IsHomalgRing ], RingName );
@InstallMethod( ViewString, [ IsHomalgRingElement ], StringDisplay );

## LaTeXOutput for homalg rings (delegating to MatricesForHomalg)
function LaTeXOutput( ring::MatricesForHomalg.Nemo.Ring )::String
    MatricesForHomalg.LaTeXOutputOfHomalgRing( ring )
end

## LaTeXOutput for homalg matrices (delegating to MatricesForHomalg)
function LaTeXOutput( mat::MatricesForHomalg.TypeOfMatrixForHomalg )::String
    MatricesForHomalg.LaTeXOutputOfHomalgMatrix( mat )
end

## LaTeXOutput for homalg ring elements (delegating to MatricesForHomalg)
function LaTeXOutput( x::MatricesForHomalg.Nemo.RingElem )::String
    MatricesForHomalg.LaTeXOutputOfHomalgRingElement( x )
end
