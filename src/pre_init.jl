# TODO: Relocate these functions to MatricesForHomalg for a better modularity
const IsHomalgRing = Filter("IsHomalgRing", MatricesForHomalg.TypeOfRingForHomalg)

const IsFieldForHomalg = Filter("IsFieldForHomalg", MatricesForHomalg.TypeOfFieldForHomalg)

function HasIsFieldForHomalg(::MatricesForHomalg.TypeOfRingForHomalg)
	false
end

function HasIsFieldForHomalg(::MatricesForHomalg.TypeOfFieldForHomalg)
	true
end

const IsHomalgRingElement = Filter("IsHomalgRingElement", MatricesForHomalg.TypeOfRingElementForHomalg)

const IsHomalgMatrix = Filter("IsHomalgMatrix", MatricesForHomalg.TypeOfMatrixForHomalg)

function HasHasInvariantBasisProperty(::Union{typeof(MatricesForHomalg.ZZ), typeof(MatricesForHomalg.QQ)})
	true
end

function HasInvariantBasisProperty(::Union{typeof(MatricesForHomalg.ZZ), typeof(MatricesForHomalg.QQ)})
	true
end

# the following operations should be part of MatricesForHomalg.jl
const NrRows = NumberRows
const NrCols = NumberColumns
const NrColumns = NumberColumns

function HomalgMatrixListList( llist, m, n, R )
    
    if m > 0 && n > 0
        
        @Assert( 1, IsList( llist ) && Length( llist ) === m );
        @Assert( 1, ForAll( llist, list -> IsList( list ) && Length( list ) === n ) );
        
    end;
    
    return HomalgMatrix( llist, m, n, R );
    
end;

function ConvertRowToMatrix( mat::MatricesForHomalg.TypeOfMatrixForHomalg, r::Int, c::Int )::MatricesForHomalg.TypeOfMatrixForHomalg
	
	@Assert( 0, NrRows( mat ) === 1 )
	@Assert( 0, NrCols( mat ) === r * c )
	
    return UnionOfRows( HomalgRing( mat ), c, List( 1:r, i -> CertainColumns( mat, ((i - 1) * c + 1):(i*c) ) ) )
	
end

function ConvertColumnToMatrix( mat::MatricesForHomalg.TypeOfMatrixForHomalg, r::Int, c::Int )::MatricesForHomalg.TypeOfMatrixForHomalg
	
	@Assert( 0, NrRows( mat ) === r * c )
	@Assert( 0, NrCols( mat ) === 1 )
	
    return UnionOfColumns( HomalgRing( mat ), r, List( 1:c, i -> CertainRows( mat, ((i - 1) * c + 1):(i*c) ) ) )
	
end

function EntriesOfHomalgMatrix( mat::MatricesForHomalg.TypeOfMatrixForHomalg )
	vcat(EntriesOfHomalgMatrixAsListList(mat)...)
end

function EntriesOfHomalgMatrixAsListList( mat::MatricesForHomalg.TypeOfMatrixForHomalg )
	[collect(mat[i,:])[:] for i in 1:NrRows(mat)]
end

function DiagMat(R, list)::MatricesForHomalg.TypeOfMatrixForHomalg
    if length(list) == 0
        return HomalgZeroMatrix(0, 0, R)
    end

    return cat(list...; dims=(1,2))
end
