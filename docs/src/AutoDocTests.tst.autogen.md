
```jldoctest AutoDocTests
julia> using MatricesForHomalg; using CAP; using MonoidalCategories; using LinearAlgebraForCAP

julia> true
true

julia> Q = HomalgFieldOfRationals();

julia> vec = MatrixCategory( Q );

julia> a = MatrixCategoryObject( vec, 3 )
<A vector space object over Q of dimension 3>

julia> IsProjective( a )
true

julia> ap = 3/vec;

julia> IsEqualForObjects( a, ap )
true

julia> b = MatrixCategoryObject( vec, 4 )
<A vector space object over Q of dimension 4>

julia> homalg_matrix = HomalgMatrix( [ [ 1, 0, 0, 0 ],
                                          [ 0, 1, 0, -1 ],
                                          [ -1, 0, 2, 1 ] ], 3, 4, Q );

julia> alpha = VectorSpaceMorphism( a, homalg_matrix, b )
<A morphism in Category of matrices over Q>

```

```jldoctest AutoDocTests
julia> using MatricesForHomalg; using CAP; using MonoidalCategories; using LinearAlgebraForCAP

julia> alphap = homalg_matrix/vec;

julia> IsCongruentForMorphisms( alpha, alphap )
true

julia> homalg_matrix = HomalgMatrix( [ [ 1, 1, 0, 0 ],
                                          [ 0, 1, 0, -1 ],
                                          [ -1, 0, 2, 1 ] ], 3, 4, Q );

julia> beta = VectorSpaceMorphism( a, homalg_matrix, b )
<A morphism in Category of matrices over Q>

julia> CokernelObject( alpha )
<A vector space object over Q of dimension 1>

julia> c = CokernelProjection( alpha );

julia> Display( EntriesOfHomalgMatrixAsListList( UnderlyingMatrix( c ) ) )
[ [ 0 ], [ 1 ], [ -1/2 ], [ 1 ] ]

julia> gamma = UniversalMorphismIntoDirectSum( [ c, c ] );

julia> Display( EntriesOfHomalgMatrixAsListList( UnderlyingMatrix( gamma ) ) )
[ [ 0, 0 ], [ 1, 1 ], [ -1/2, -1/2 ], [ 1, 1 ] ]

julia> colift = CokernelColift( alpha, gamma );

julia> IsEqualForMorphisms( PreCompose( c, colift ), gamma )
true

julia> FiberProduct( alpha, beta )
<A vector space object over Q of dimension 2>

julia> F = FiberProduct( alpha, beta )
<A vector space object over Q of dimension 2>

julia> p1 = ProjectionInFactorOfFiberProduct( [ alpha, beta ], 1 )
<A morphism in Category of matrices over Q>

julia> Display( EntriesOfHomalgMatrixAsListList( UnderlyingMatrix( PreCompose( p1, alpha ) ) ) )
[ [ 0, 1, 0, -1 ], [ -1, 0, 2, 1 ] ]

julia> Pushout( alpha, beta )
<A vector space object over Q of dimension 5>

julia> i1 = InjectionOfCofactorOfPushout( [ alpha, beta ], 1 )
<A morphism in Category of matrices over Q>

julia> i2 = InjectionOfCofactorOfPushout( [ alpha, beta ], 2 )
<A morphism in Category of matrices over Q>

julia> u = UniversalMorphismFromDirectSum( [ b, b ], [ i1, i2 ] )
<A morphism in Category of matrices over Q>

```

```jldoctest AutoDocTests
julia> using MatricesForHomalg; using CAP; using MonoidalCategories; using LinearAlgebraForCAP

julia> KernelObjectFunctorial( u, IdentityMorphism( Source( u ) ), u ) == IdentityMorphism( MatrixCategoryObject( vec, 3 ) )
true

julia> IsZeroForMorphisms( CokernelObjectFunctorial( u, IdentityMorphism( Range( u ) ), u ) )
true

julia> DirectProductFunctorial( [ u, u ] ) == DirectSumFunctorial( [ u, u ] )
true

julia> CoproductFunctorial( [ u, u ] ) == DirectSumFunctorial( [ u, u ] )
true

julia> IsCongruentForMorphisms(
            FiberProductFunctorial( [ u, u ], [ IdentityMorphism( Source( u ) ), IdentityMorphism( Source( u ) ) ], [ u, u ] ),
            IdentityMorphism( FiberProduct( [ u, u ] ) )
        )
true

julia> IsCongruentForMorphisms(
            PushoutFunctorial( [ u, u ], [ IdentityMorphism( Range( u ) ), IdentityMorphism( Range( u ) ) ], [ u, u ] ),
            IdentityMorphism( Pushout( [ u, u ] ) )
        )
true

julia> IsCongruentForMorphisms( ((1/2) / Q) * alpha, alpha * ((1/2) / Q) )
true

julia> Dimension( HomomorphismStructureOnObjects( a, b ) ) == Dimension( a ) * Dimension( b )
true

julia> IsCongruentForMorphisms(
            PreCompose( [ u, DualOnMorphisms( i1 ), DualOnMorphisms( alpha ) ] ),
            InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( Source( u ), Source( alpha ),
                 PreCompose(
                     InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( DualOnMorphisms( i1 ) ),
                     HomomorphismStructureOnMorphisms( u, DualOnMorphisms( alpha ) )
                 )
            )
        )
true

julia> op = Opposite( vec );

julia> alpha_op = Opposite( op, alpha )
<A morphism in Opposite( Category of matrices over Q )>

julia> basis = BasisOfExternalHom( Source( alpha_op ), Range( alpha_op ) );

julia> coeffs = CoefficientsOfMorphism( alpha_op );

julia> Display( coeffs )
[ 1, 0, 0, 0, 0, 1, 0, -1, -1, 0, 2, 1 ]

julia> IsEqualForMorphisms( alpha_op, LinearCombinationOfMorphisms( Source( alpha_op ), coeffs, basis, Range( alpha_op ) ) )
true

julia> vec = CapCategory( alpha );

julia> t = TensorUnit( vec );

julia> z = ZeroObject( vec );

julia> IsCongruentForMorphisms(
            ZeroObjectFunctorial( vec ),
            InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( z, z, ZeroMorphism( t, z ) )
        )
true

julia> IsCongruentForMorphisms(
            ZeroObjectFunctorial( vec ),
            InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism(
                z, z,
                InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( ZeroObjectFunctorial( vec ) )
            )
        )
true

julia> right_side = PreCompose( [ i1, DualOnMorphisms( u ), u ] );

julia> x = SolveLinearSystemInAbCategory( [ [ i1 ] ], [ [ u ] ], [ right_side ] )[1];

julia> IsCongruentForMorphisms( PreCompose( [ i1, x, u ] ), right_side )
true

julia> a_otimes_b = TensorProductOnObjects( a, b )
<A vector space object over Q of dimension 12>

julia> hom_ab = InternalHomOnObjects( a, b )
<A vector space object over Q of dimension 12>

julia> cohom_ab = InternalCoHomOnObjects( a, b )
<A vector space object over Q of dimension 12>

julia> hom_ab == cohom_ab
true

julia> unit_ab = VectorSpaceMorphism(
                  a_otimes_b,
                  HomalgIdentityMatrix( Dimension( a_otimes_b ), Q ),
                  a_otimes_b
                  )
<A morphism in Category of matrices over Q>

julia> unit_hom_ab = VectorSpaceMorphism(
                      hom_ab,
                      HomalgIdentityMatrix( Dimension( hom_ab ), Q ),
                      hom_ab
                    )
<A morphism in Category of matrices over Q>

julia> unit_cohom_ab = VectorSpaceMorphism(
                        cohom_ab,
                        HomalgIdentityMatrix( Dimension( cohom_ab ), Q ),
                        cohom_ab
                      )
<A morphism in Category of matrices over Q>

julia> ev_ab = ClosedMonoidalLeftEvaluationMorphism( a, b )
<A morphism in Category of matrices over Q>

julia> coev_ab = ClosedMonoidalLeftCoevaluationMorphism( a, b )
<A morphism in Category of matrices over Q>

julia> coev_ba = ClosedMonoidalLeftCoevaluationMorphism( b, a )
<A morphism in Category of matrices over Q>

julia> cocl_ev_ab = CoclosedMonoidalLeftEvaluationMorphism( a, b )
<A morphism in Category of matrices over Q>

julia> cocl_ev_ba = CoclosedMonoidalLeftEvaluationMorphism( b, a )
<A morphism in Category of matrices over Q>

julia> cocl_coev_ab = CoclosedMonoidalLeftCoevaluationMorphism( a, b )
<A morphism in Category of matrices over Q>

julia> cocl_coev_ba = CoclosedMonoidalLeftCoevaluationMorphism( b, a )
<A morphism in Category of matrices over Q>

julia> UnderlyingMatrix( ev_ab ) == TransposedMatrix( UnderlyingMatrix( cocl_ev_ab ) )
true

julia> UnderlyingMatrix( coev_ab ) == TransposedMatrix( UnderlyingMatrix( cocl_coev_ab ) )
true

julia> UnderlyingMatrix( coev_ba ) == TransposedMatrix( UnderlyingMatrix( cocl_coev_ba ) )
true

julia> tensor_hom_adj_1_hom_ab = InternalHomToTensorProductLeftAdjunctMorphism( a, b, unit_hom_ab )
<A morphism in Category of matrices over Q>

julia> cohom_tensor_adj_1_cohom_ab = InternalCoHomToTensorProductLeftAdjunctMorphism( a, b, unit_cohom_ab )
<A morphism in Category of matrices over Q>

julia> tensor_hom_adj_1_ab = TensorProductToInternalHomLeftAdjunctMorphism( a, b, unit_ab )
<A morphism in Category of matrices over Q>

julia> cohom_tensor_adj_1_ab = TensorProductToInternalCoHomLeftAdjunctMorphism( a, b, unit_ab )
<A morphism in Category of matrices over Q>

julia> ev_ab == tensor_hom_adj_1_hom_ab
true

julia> cocl_ev_ba == cohom_tensor_adj_1_cohom_ab
true

julia> coev_ba == tensor_hom_adj_1_ab
true

julia> cocl_coev_ba == cohom_tensor_adj_1_ab
true

julia> c = MatrixCategoryObject( vec, 2 )
<A vector space object over Q of dimension 2>

julia> d = MatrixCategoryObject( vec, 1 )
<A vector space object over Q of dimension 1>

```

```jldoctest AutoDocTests
julia> using MatricesForHomalg; using CAP; using MonoidalCategories; using LinearAlgebraForCAP

julia> pre_compose = MonoidalPreComposeMorphism( a, b, c )
<A morphism in Category of matrices over Q>

julia> post_compose = MonoidalPostComposeMorphism( a, b, c )
<A morphism in Category of matrices over Q>

julia> pre_cocompose = MonoidalPreCoComposeMorphism( c, b, a )
<A morphism in Category of matrices over Q>

julia> post_cocompose = MonoidalPostCoComposeMorphism( c, b, a )
<A morphism in Category of matrices over Q>

julia> UnderlyingMatrix( pre_compose ) == TransposedMatrix( UnderlyingMatrix( pre_cocompose ) )
true

julia> UnderlyingMatrix( post_compose ) == TransposedMatrix( UnderlyingMatrix( post_cocompose ) )
true

julia> tp_hom_comp = TensorProductInternalHomCompatibilityMorphism( [ a, b, c, d ] )
<A morphism in Category of matrices over Q>

julia> cohom_tp_comp = InternalCoHomTensorProductCompatibilityMorphism( [ b, d, a, c ] )
<A morphism in Category of matrices over Q>

julia> UnderlyingMatrix( tp_hom_comp ) == TransposedMatrix( UnderlyingMatrix( cohom_tp_comp ) )
true

julia> lambda = LambdaIntroduction( alpha )
<A morphism in Category of matrices over Q>

julia> lambda_elim = LambdaElimination( a, b, lambda )
<A morphism in Category of matrices over Q>

julia> alpha == lambda_elim
true

julia> alpha_op = VectorSpaceMorphism( b, TransposedMatrix( UnderlyingMatrix( alpha ) ), a )
<A morphism in Category of matrices over Q>

julia> colambda = CoLambdaIntroduction( alpha_op )
<A morphism in Category of matrices over Q>

julia> colambda_elim = CoLambdaElimination( b, a, colambda )
<A morphism in Category of matrices over Q>

julia> alpha_op == colambda_elim
true

julia> UnderlyingMatrix( lambda ) == TransposedMatrix( UnderlyingMatrix( colambda ) )
true

julia> delta = PreCompose( colambda, lambda)
<A morphism in Category of matrices over Q>

julia> Display( EntriesOfHomalgMatrixAsListList( UnderlyingMatrix( TraceMap( delta ) ) ) )
[ [ 9 ] ]

julia> Display( EntriesOfHomalgMatrixAsListList( UnderlyingMatrix( CoTraceMap( delta ) ) ) )
[ [ 9 ] ]

julia> TraceMap( delta ) == CoTraceMap( delta )
true

julia> RankMorphism( a ) == CoRankMorphism( a )
true

```

```jldoctest AutoDocTests
julia> using MatricesForHomalg; using CAP; using MonoidalCategories; using LinearAlgebraForCAP

julia> true
true

julia> ring = HomalgFieldOfRationals( );

julia> vec = MatrixCategory( ring );

julia> F = CapFunctor( "CohomForVec", [ vec, [ vec, true ] ], vec );

julia> obj_func = function( A, B ) return TensorProductOnObjects( A, DualOnObjects( B ) ); end;

julia> mor_func = function( source, alpha, beta, range ) return TensorProductOnMorphismsWithGivenTensorProducts( source, alpha, DualOnMorphisms( beta ), range ); end;

julia> AddObjectFunction( F, obj_func );

julia> AddMorphismFunction( F, mor_func );

julia> Display( InputSignature( F ) )
[ [ Category of matrices over Q, false ], [ Category of matrices over Q, true ] ]

julia> V1 = TensorUnit( vec );

julia> V3 = DirectSum( V1, V1, V1 );

julia> pi1 = ProjectionInFactorOfDirectSum( [ V1, V1 ], 1 );

julia> pi2 = ProjectionInFactorOfDirectSum( [ V3, V1 ], 1 );

julia> value1 = ApplyFunctor( F, pi1, pi2 );

julia> input = ProductCategoryMorphism( AsCapCategory( Source( F ) ), [ pi1, Opposite( pi2 ) ] );

julia> value2 = ApplyFunctor( F, input );

julia> IsCongruentForMorphisms( value1, value2 )
true

julia> InstallFunctor( F, "F_installation" );

julia> F_installation( pi1, pi2 );

julia> F_installation( input );

julia> F_installationOnObjects( V1, V1 );

julia> F_installationOnObjects( ProductCategoryObject( AsCapCategory( Source( F ) ), [ V1, Opposite( V1 ) ] ) );

julia> F_installationOnMorphisms( pi1, pi2 );

julia> F_installationOnMorphisms( input );

julia> F2 = CapFunctor( "CohomForVec2", ProductCategory( [ vec, Opposite( vec ) ] ), vec );

julia> AddObjectFunction( F2, a -> obj_func( a[1], Opposite( a[2] ) ) );

julia> AddMorphismFunction( F2, function( source, datum, range ) return mor_func( source, datum[1], Opposite( datum[2] ), range ); end );

julia> input = ProductCategoryMorphism( AsCapCategory( Source( F2 ) ), [ pi1, Opposite( pi2 ) ] );

julia> value3 = ApplyFunctor( F2, input );

julia> IsCongruentForMorphisms( value1, value3 )
true

julia> Display( InputSignature( F2 ) )
[ [ Product of: Category of matrices over Q, Opposite( Category of matrices over Q ), false ] ]

julia> InstallFunctor( F2, "F_installation2" );

julia> F_installation2( input );

julia> F_installation2OnObjects( ProductCategoryObject( AsCapCategory( Source( F2 ) ), [ V1, Opposite( V1 ) ] ) );

julia> F_installation2OnMorphisms( input );

```

```jldoctest AutoDocTests
julia> using MatricesForHomalg; using CAP; using MonoidalCategories; using LinearAlgebraForCAP

julia> true
true

julia> QQ = HomalgFieldOfRationals();

julia> QQ_mat = MatrixCategory( QQ )
Category of matrices over Q

julia> t = TensorUnit( QQ_mat )
<A vector space object over Q of dimension 1>

julia> id_t = IdentityMorphism( t )
<A morphism in Category of matrices over Q>

julia> 1*(11)*7 + 2*(12)*8 + 3*(13)*9
620

julia> 4*(11)*3 + 5*(12)*4 + 6*(13)*1
450

julia> alpha =  [ [ 1/QQ * id_t, 2/QQ * id_t, 3/QQ * id_t ], [ 4/QQ * id_t, 5/QQ * id_t, 6/QQ * id_t ] ];

julia> beta = [ [ 7/QQ * id_t, 8/QQ * id_t, 9/QQ * id_t ], [ 3/QQ * id_t, 4/QQ * id_t, 1/QQ * id_t ] ];

julia> gamma = [ 620/QQ * id_t, 450/QQ * id_t ];

julia> MereExistenceOfSolutionOfLinearSystemInAbCategory(
                                          QQ_mat, alpha, beta, gamma )
true

julia> MereExistenceOfUniqueSolutionOfLinearSystemInAbCategory(
                                          QQ_mat, alpha, beta, gamma )
false

julia> x = SolveLinearSystemInAbCategory( QQ_mat, alpha, beta, gamma );

julia> (1*7)/QQ * x[1] + (2*8)/QQ * x[2] + (3*9)/QQ * x[3] == gamma[1]
true

julia> (4*3)/QQ * x[1] + (5*4)/QQ * x[2] + (6*1)/QQ * x[3] == gamma[2]
true

julia> MereExistenceOfUniqueSolutionOfHomogeneousLinearSystemInAbCategory(
                                          QQ_mat, alpha, beta )
false

julia> B = BasisOfSolutionsOfHomogeneousLinearSystemInLinearCategory(
                                          QQ_mat, alpha, beta );

julia> Length( B )
1

julia> (1*7)/QQ * B[1][1] + (2*8)/QQ * B[1][2] + (3*9)/QQ * B[1][3] == 0/QQ * id_t
true

julia> (4*3)/QQ * B[1][1] + (5*4)/QQ * B[1][2] + (6*1)/QQ * B[1][3] == 0/QQ * id_t
true

julia> 2*(11)*5 + 3*(12)*7 + 9*(13)*2
596

julia> Add( alpha, [ 2/QQ * id_t, 3/QQ * id_t, 9/QQ * id_t ] );

julia> Add( beta, [ 5/QQ * id_t, 7/QQ * id_t, 2/QQ * id_t ] );

julia> Add( gamma, 596/QQ * id_t );

julia> MereExistenceOfSolutionOfLinearSystemInAbCategory(
                                          QQ_mat, alpha, beta, gamma )
true

julia> MereExistenceOfUniqueSolutionOfLinearSystemInAbCategory(
                                          QQ_mat, alpha, beta, gamma )
true

julia> x = SolveLinearSystemInAbCategory( QQ_mat, alpha, beta, gamma );

julia> (1*7)/QQ * x[1] + (2*8)/QQ * x[2] + (3*9)/QQ * x[3] == gamma[1]
true

julia> (4*3)/QQ * x[1] + (5*4)/QQ * x[2] + (6*1)/QQ * x[3] == gamma[2]
true

julia> (2*5)/QQ * x[1] + (3*7)/QQ * x[2] + (9*2)/QQ * x[3] == gamma[3]
true

julia> MereExistenceOfUniqueSolutionOfHomogeneousLinearSystemInAbCategory(
                                          QQ_mat, alpha, beta )
true

julia> B = BasisOfSolutionsOfHomogeneousLinearSystemInLinearCategory(
                                          QQ_mat, alpha, beta );

julia> Length( B )
0

julia> alpha = [ [ 2/QQ * id_t, 3/QQ * id_t ] ];

julia> delta = [ [ 3/QQ * id_t, 3/QQ * id_t ] ];

julia> B = BasisOfSolutionsOfHomogeneousDoubleLinearSystemInLinearCategory( alpha, delta );

julia> Length( B )
1

julia> mor1 = PreCompose( alpha[1][1], B[1][1] ) + PreCompose( alpha[1][2], B[1][2] )
<A morphism in Category of matrices over Q>

julia> mor2 = PreCompose( B[1][1], delta[1][1] ) + PreCompose( B[1][2], delta[1][2] )
<A morphism in Category of matrices over Q>

julia> mor1 == mor2
true

```

```jldoctest AutoDocTests
julia> using MatricesForHomalg; using CAP; using MonoidalCategories; using LinearAlgebraForCAP

julia> field = HomalgFieldOfRationals( );

julia> vec = MatrixCategory( field );

julia> A = MatrixCategoryObject( vec, 1 );

julia> B = MatrixCategoryObject( vec, 2 );

julia> C = MatrixCategoryObject( vec, 3 );

julia> alpha = VectorSpaceMorphism( A, HomalgMatrix( [ [ 1, 0, 0 ] ], 1, 3, field ), C );

julia> beta = VectorSpaceMorphism( C, HomalgMatrix( [ [ 1, 0 ], [ 1, 1 ], [ 1, 2 ] ], 3, 2, field ), B );

julia> IsZeroForMorphisms( PreCompose( alpha, beta ) )
false

julia> IsCongruentForMorphisms(
            IdentityMorphism( HomologyObject( alpha, beta ) ),
            HomologyObjectFunctorial( alpha, beta, IdentityMorphism( C ), alpha, beta )
        )
true

julia> kernel_beta = KernelEmbedding( beta );

julia> K = Source( kernel_beta );

julia> IsIsomorphism(
            HomologyObjectFunctorial( 
                MorphismFromZeroObject( K ), 
                MorphismIntoZeroObject( K ),
                kernel_beta,
                MorphismFromZeroObject( Source( beta ) ),
                beta
            )
        )
true

julia> cokernel_alpha = CokernelProjection( alpha );

julia> Co = Range( cokernel_alpha );

julia> IsIsomorphism(
            HomologyObjectFunctorial( 
                alpha,
                MorphismIntoZeroObject( Range( alpha ) ),
                cokernel_alpha,
                MorphismFromZeroObject( Co ),
                MorphismIntoZeroObject( Co )
            )
        )
true

julia> op = Opposite( vec );

julia> alpha_op = Opposite( op, alpha );

julia> beta_op = Opposite( op, beta );

julia> IsCongruentForMorphisms(
            IdentityMorphism( HomologyObject( beta_op, alpha_op ) ),
            HomologyObjectFunctorial( beta_op, alpha_op, IdentityMorphism( Opposite( C ) ), beta_op, alpha_op )
        )
true

julia> kernel_beta = KernelEmbedding( beta_op );

julia> K = Source( kernel_beta );

julia> IsIsomorphism(
            HomologyObjectFunctorial( 
                MorphismFromZeroObject( K ), 
                MorphismIntoZeroObject( K ),
                kernel_beta,
                MorphismFromZeroObject( Source( beta_op ) ),
                beta_op
            )
        )
true

julia> cokernel_alpha = CokernelProjection( alpha_op );

julia> Co = Range( cokernel_alpha );

julia> IsIsomorphism(
            HomologyObjectFunctorial( 
                alpha_op,
                MorphismIntoZeroObject( Range( alpha_op ) ),
                cokernel_alpha,
                MorphismFromZeroObject( Co ),
                MorphismIntoZeroObject( Co )
            )
        )
true

```

```jldoctest AutoDocTests
julia> using MatricesForHomalg; using CAP; using MonoidalCategories; using LinearAlgebraForCAP

julia> field = HomalgFieldOfRationals( );

julia> vec = MatrixCategory( field );

julia> V = MatrixCategoryObject( vec, 1 );

julia> W = MatrixCategoryObject( vec, 2 );

julia> alpha = VectorSpaceMorphism( V, HomalgMatrix( [ [ 1, -1 ] ], 1, 2, field ), W );

julia> beta = VectorSpaceMorphism( W, HomalgMatrix( [ [ 1, 2 ], [ 3, 4 ] ], 2, 2, field ), W );

julia> IsLiftable( alpha, beta )
true

julia> IsLiftable( beta, alpha )
false

julia> IsLiftableAlongMonomorphism( beta, alpha )
true

julia> gamma = VectorSpaceMorphism( W, HomalgMatrix( [ [ 1 ], [ 1 ] ], 2, 1, field ), V );

julia> IsColiftable( beta, gamma )
true

julia> IsColiftable( gamma, beta )
false

julia> IsColiftableAlongEpimorphism( beta, gamma )
true

julia> PreCompose( PreInverseForMorphisms( gamma ), gamma ) == IdentityMorphism( V )
true

julia> PreCompose( alpha, PostInverseForMorphisms( alpha ) ) == IdentityMorphism( V )
true

```

```jldoctest AutoDocTests
julia> using MatricesForHomalg; using CAP; using MonoidalCategories; using LinearAlgebraForCAP

julia> true
true

julia> Q = HomalgFieldOfRationals();

julia> vec = MatrixCategory( Q );

julia> a = MatrixCategoryObject( vec, 1 )
<A vector space object over Q of dimension 1>

julia> b = MatrixCategoryObject( vec, 2 )
<A vector space object over Q of dimension 2>

julia> c = MatrixCategoryObject( vec, 3 )
<A vector space object over Q of dimension 3>

julia> z = ZeroObject( vec )
<A vector space object over Q of dimension 0>

julia> alpha = VectorSpaceMorphism( a, [ [ 1, 0 ] ], b )
<A morphism in Category of matrices over Q>

julia> beta = VectorSpaceMorphism( b,
                        [ [ 1, 0, 0 ], [ 0, 1, 0 ] ], c )
<A morphism in Category of matrices over Q>

julia> gamma = VectorSpaceMorphism( c,
                         [ [ 0, 1, 1 ], [ 1, 0, 1 ], [ 1, 1, 0 ] ], c )
<A morphism in Category of matrices over Q>

julia> IsCongruentForMorphisms(
            TensorProductOnMorphisms( alpha, beta ),
            TensorProductOnMorphisms( beta, alpha )
        )
false

julia> IsCongruentForMorphisms(
            AssociatorRightToLeft( a, b, c ),
            IdentityMorphism( TensorProductOnObjects( a, TensorProductOnObjects( b, c ) ) )
        )
true

julia> IsCongruentForMorphisms(
            gamma,
            LambdaElimination( c, c, LambdaIntroduction( gamma ) )
        )
true

julia> IsZeroForMorphisms( TraceMap( gamma ) )
true

julia> IsCongruentForMorphisms(
            RankMorphism( DirectSum( a, b ) ),
            RankMorphism( c )
        )
true

julia> IsCongruentForMorphisms(
            Braiding( b, c ),
            IdentityMorphism( TensorProductOnObjects( b, c ) )
        )
false

julia> IsCongruentForMorphisms(
            PreCompose( Braiding( b, c ), Braiding( c, b ) ),
            IdentityMorphism( TensorProductOnObjects( b, c ) )
        )
true

```

```jldoctest AutoDocTests
julia> using MatricesForHomalg; using CAP; using MonoidalCategories; using LinearAlgebraForCAP

julia> field = HomalgFieldOfRationals( );

julia> vec = MatrixCategory( field );

julia> A = MatrixCategoryObject( vec, 3 );

julia> B = MatrixCategoryObject( vec, 2 );

julia> alpha = VectorSpaceMorphism( B, HomalgMatrix( [ [ 1, -1, 1 ], [ 1, 1, 1 ] ], 2, 3, field ), A );

julia> beta = VectorSpaceMorphism( B, HomalgMatrix( [ [ 1, 2, 1 ], [ 2, 1, 1 ] ], 2, 3, field ), A );

julia> m = MorphismFromFiberProductToSink( [ alpha, beta ] );

julia> IsCongruentForMorphisms(
            m,
            PreCompose( ProjectionInFactorOfFiberProduct( [ alpha, beta ], 1 ), alpha )
        )
true

julia> IsCongruentForMorphisms(
            m,
            PreCompose( ProjectionInFactorOfFiberProduct( [ alpha, beta ], 2 ), beta )
        )
true

julia> IsCongruentForMorphisms(
        MorphismFromKernelObjectToSink( alpha ),
            PreCompose( KernelEmbedding( alpha ), alpha )
        )
true

julia> alpha_p = DualOnMorphisms( alpha );

julia> beta_p = DualOnMorphisms( beta );

julia> m_p = MorphismFromSourceToPushout( [ alpha_p, beta_p ] );

julia> IsCongruentForMorphisms(
            m_p,
            PreCompose( alpha_p, InjectionOfCofactorOfPushout( [ alpha_p, beta_p ], 1 ) )
        )
true

julia> IsCongruentForMorphisms(
            m_p,
            PreCompose( beta_p, InjectionOfCofactorOfPushout( [ alpha_p, beta_p ], 2 ) )
        )
true

julia> IsCongruentForMorphisms(
            MorphismFromSourceToCokernelObject( alpha_p ),
            PreCompose( alpha_p, CokernelProjection( alpha_p ) )
        )
true

```

```jldoctest AutoDocTests
julia> using MatricesForHomalg; using CAP; using MonoidalCategories; using LinearAlgebraForCAP

julia> true
true

julia> QQ = HomalgFieldOfRationals();

julia> vec = MatrixCategory( QQ );

julia> op = Opposite( vec );

julia> Display( ListKnownCategoricalProperties( op ) )
[ "IsAbCategory", "IsAbelianCategory", "IsAbelianCategoryWithEnoughInjectives", "IsAbelianCategoryWithEnoughProjectives", "IsAdditiveCategory", "IsBraidedMonoidalCategory", "IsCategoryWithCoequalizers", "IsCategoryWithCokernels", "IsCategoryWithEqualizers", "IsCategoryWithInitialObject", "IsCategoryWithKernels", "IsCategoryWithTerminalObject", "IsCategoryWithZeroObject", "IsClosedMonoidalCategory", "IsCoclosedMonoidalCategory", "IsEnrichedOverCommutativeRegularSemigroup", "IsEquippedWithHomomorphismStructure", "IsLinearCategoryOverCommutativeRing", "IsLinearCategoryOverCommutativeRingWithFinitelyGeneratedFreeExternalHoms", "IsMonoidalCategory", "IsPreAbelianCategory", "IsRigidSymmetricClosedMonoidalCategory", "IsRigidSymmetricCoclosedMonoidalCategory", "IsSkeletalCategory", "IsStrictMonoidalCategory", "IsSymmetricClosedMonoidalCategory", "IsSymmetricCoclosedMonoidalCategory", "IsSymmetricMonoidalCategory" ]

julia> V1 = Opposite( TensorUnit( vec ) );

julia> V2 = DirectSum( V1, V1 );

julia> V3 = DirectSum( V1, V2 );

julia> V4 = DirectSum( V1, V3 );

julia> V5 = DirectSum( V1, V4 );

julia> IsWellDefined( MorphismBetweenDirectSums( op, [ ], [ ], [ V1 ] ) )
true

julia> IsWellDefined( MorphismBetweenDirectSums( op, [ V1 ], [ [ ] ], [ ] ) )
true

julia> alpha13 = InjectionOfCofactorOfDirectSum( [ V1, V2 ], 1 );

julia> alpha14 = InjectionOfCofactorOfDirectSum( [ V1, V2, V1 ], 3 );

julia> alpha15 = InjectionOfCofactorOfDirectSum( [ V2, V1, V2 ], 2 );

julia> alpha23 = InjectionOfCofactorOfDirectSum( [ V2, V1 ], 1 );

julia> alpha24 = InjectionOfCofactorOfDirectSum( [ V1, V2, V1 ], 2 );

julia> alpha25 = InjectionOfCofactorOfDirectSum( [ V2, V2, V1 ], 1 );

julia> mat = [
            [ alpha13, alpha14, alpha15 ],
            [ alpha23, alpha24, alpha25 ]
        ];

julia> mor = MorphismBetweenDirectSums( mat );

julia> IsWellDefined( mor )
true

julia> IsWellDefined( Opposite( mor ) )
true

julia> IsCongruentForMorphisms(
            UniversalMorphismFromImage( mor, [ CoastrictionToImage( mor ), ImageEmbedding( mor ) ] ),
            IdentityMorphism( ImageObject( mor ) )
        )
true

```

```jldoctest AutoDocTests
julia> using MatricesForHomalg; using CAP; using MonoidalCategories; using LinearAlgebraForCAP

julia> field = HomalgFieldOfRationals( );

julia> vec = MatrixCategory( field );

julia> A = MatrixCategoryObject( vec, 1 );

julia> B = MatrixCategoryObject( vec, 2 );

julia> C = MatrixCategoryObject( vec, 3 );

julia> alpha = VectorSpaceMorphism( A, HomalgMatrix( [ [ 1, 0, 0 ] ], 1, 3, field ), C );

julia> beta = VectorSpaceMorphism( C, HomalgMatrix( [ [ 1, 0 ], [ 1, 1 ], [ 1, 2 ] ], 3, 2, field ), B );

julia> IsCongruentForMorphisms( PreCompose( alpha, beta ), PostCompose( beta, alpha ) )
true

julia> IsCongruentForMorphisms( PreComposeList( A, [ ], A ), IdentityMorphism( A ) )
true

julia> IsCongruentForMorphisms( PreComposeList( A, [ alpha ], C ), alpha )
true

julia> IsCongruentForMorphisms( PreComposeList( A, [ alpha, beta ], B ), PreCompose( alpha, beta ) )
true

julia> IsCongruentForMorphisms( PostComposeList( A, [ ], A ), IdentityMorphism( A ) )
true

julia> IsCongruentForMorphisms( PostComposeList( A, [ alpha ], C ), alpha )
true

julia> IsCongruentForMorphisms( PostComposeList( A, [ beta, alpha ], B ), PostCompose( beta, alpha ) )
true

```

```jldoctest AutoDocTests
julia> using MatricesForHomalg; using CAP; using MonoidalCategories; using LinearAlgebraForCAP

julia> true
true

julia> Q = HomalgFieldOfRationals();

julia> Qmat = MatrixCategory( Q );

julia> a = MatrixCategoryObject( Qmat, 3 );

julia> b = MatrixCategoryObject( Qmat, 4 );

julia> homalg_matrix = HomalgMatrix( [ [ 1, 0, 0, 0 ],
                                          [ 0, 1, 0, -1 ],
                                          [ -1, 0, 2, 1 ] ], 3, 4, Q );

julia> alpha = VectorSpaceMorphism( a, homalg_matrix, b );

julia> beta = SomeReductionBySplitEpiSummand( alpha );

julia> IsWellDefinedForMorphisms( beta )
true

julia> Dimension( Source( beta ) )
0

julia> Dimension( Range( beta ) )
1

julia> gamma = SomeReductionBySplitEpiSummand_MorphismFromInputRange( alpha );

julia> Display( EntriesOfHomalgMatrixAsListList( UnderlyingMatrix( gamma ) ) )
[ [ 0 ], [ 1 ], [ -1/2 ], [ 1 ] ]

```

```jldoctest AutoDocTests
julia> using MatricesForHomalg; using CAP; using MonoidalCategories; using LinearAlgebraForCAP

julia> Q = HomalgFieldOfRationals();

julia> vec = MatrixCategory( Q );

julia> V = MatrixCategoryObject( vec, 2 )
<A vector space object over Q of dimension 2>

julia> W = MatrixCategoryObject( vec, 3 )
<A vector space object over Q of dimension 3>

julia> alpha = VectorSpaceMorphism( V, [ [ 1, 1, 1 ], [ -1, -1, -1 ] ], W )
<A morphism in Category of matrices over Q>

julia> k = KernelObject( alpha )
<A vector space object over Q of dimension 1>

julia> T = MatrixCategoryObject( vec, 2 )
<A vector space object over Q of dimension 2>

julia> tau = VectorSpaceMorphism( T, [ [ 2, 2 ], [ 2, 2 ] ], V )
<A morphism in Category of matrices over Q>

julia> k_lift = KernelLift( alpha, tau )
<A morphism in Category of matrices over Q>

julia> HasKernelEmbedding( alpha )
false

julia> KernelEmbedding( alpha )
<A morphism in Category of matrices over Q>

```

```jldoctest AutoDocTests
julia> using MatricesForHomalg; using CAP; using MonoidalCategories; using LinearAlgebraForCAP

julia> Q = HomalgFieldOfRationals();

julia> vec = MatrixCategory( Q );

julia> V = MatrixCategoryObject( vec, 2 )
<A vector space object over Q of dimension 2>

julia> W = MatrixCategoryObject( vec, 3 )
<A vector space object over Q of dimension 3>

julia> alpha = VectorSpaceMorphism( V, [ [ 1, 1, 1 ], [ -1, -1, -1 ] ], W )
<A morphism in Category of matrices over Q>

julia> k = KernelObject( alpha )
<A vector space object over Q of dimension 1>

julia> T = MatrixCategoryObject( vec, 2 )
<A vector space object over Q of dimension 2>

julia> tau = VectorSpaceMorphism( T, [ [ 2, 2 ], [ 2, 2 ] ], V )
<A morphism in Category of matrices over Q>

julia> k_lift = KernelLift( alpha, tau )
<A morphism in Category of matrices over Q>

julia> HasKernelEmbedding( alpha )
false

```

```jldoctest AutoDocTests
julia> using MatricesForHomalg; using CAP; using MonoidalCategories; using LinearAlgebraForCAP

julia> Q = HomalgFieldOfRationals();

julia> vec = MatrixCategory( Q );

julia> V = MatrixCategoryObject( vec, 2 )
<A vector space object over Q of dimension 2>

julia> W = MatrixCategoryObject( vec, 3 )
<A vector space object over Q of dimension 3>

julia> alpha = VectorSpaceMorphism( V, [ [ 1, 1, 1 ], [ -1, -1, -1 ] ], W )
<A morphism in Category of matrices over Q>

julia> k = KernelObject( alpha )
<A vector space object over Q of dimension 1>

julia> k_emb = KernelEmbedding( alpha )
<A morphism in Category of matrices over Q>

julia> IsEqualForObjects( Source( k_emb ), k )
true

julia> V = MatrixCategoryObject( vec, 2 )
<A vector space object over Q of dimension 2>

julia> W = MatrixCategoryObject( vec, 3 )
<A vector space object over Q of dimension 3>

julia> beta = VectorSpaceMorphism( V, [ [ 1, 1, 1 ], [ -1, -1, -1 ] ], W )
<A morphism in Category of matrices over Q>

julia> k_emb = KernelEmbedding( beta )
<A morphism in Category of matrices over Q>

julia> IsIdenticalObj( Source( k_emb ), KernelObject( beta ) )
true

```

```jldoctest AutoDocTests
julia> using MatricesForHomalg; using CAP; using MonoidalCategories; using LinearAlgebraForCAP

julia> Q = HomalgFieldOfRationals();

julia> vec = MatrixCategory( Q );

julia> A = MatrixCategoryObject( vec, 1 )
<A vector space object over Q of dimension 1>

julia> B = MatrixCategoryObject( vec, 2 )
<A vector space object over Q of dimension 2>

julia> C = MatrixCategoryObject( vec, 3 )
<A vector space object over Q of dimension 3>

julia> AtoC = VectorSpaceMorphism( A, [ [ 1, 2, 0 ] ], C )
<A morphism in Category of matrices over Q>

julia> BtoC = VectorSpaceMorphism( B, [ [ 1, 0, 0 ], [ 0, 1, 0 ] ], C )
<A morphism in Category of matrices over Q>

julia> P = FiberProduct( AtoC, BtoC )
<A vector space object over Q of dimension 1>

julia> p1 = ProjectionInFactorOfFiberProduct( [ AtoC, BtoC ], 1 )
<A morphism in Category of matrices over Q>

julia> p2 = ProjectionInFactorOfFiberProduct( [ AtoC, BtoC ], 2 )
<A morphism in Category of matrices over Q>

```

```jldoctest AutoDocTests
julia> using MatricesForHomalg; using CAP; using MonoidalCategories; using LinearAlgebraForCAP

julia> true
true

julia> Q = HomalgFieldOfRationals( );

julia> Qmat = MatrixCategory( Q )
Category of matrices over Q

julia> Wrapper = WrapperCategory( Qmat, @rec( ) )
WrapperCategory( Category of matrices over Q )

julia> mor = ZeroMorphism( ZeroObject( Wrapper ), ZeroObject( Wrapper ) );

julia> (2 / Q) * mor;

julia> BasisOfExternalHom( Source( mor ), Range( mor ) );

julia> CoefficientsOfMorphism( mor );

julia> distinguished_object = DistinguishedObjectOfHomomorphismStructure( Wrapper );

julia> object = HomomorphismStructureOnObjects( Source( mor ), Source( mor ) );

julia> HomomorphismStructureOnMorphisms( mor, mor );

julia> HomomorphismStructureOnMorphismsWithGivenObjects( object, mor, mor, object );

julia> iota = InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( mor );

julia> InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjects( distinguished_object, mor, object );

julia> beta = InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( Source( mor ), Range( mor ), iota );

julia> IsCongruentForMorphisms( mor, beta )
true

```
