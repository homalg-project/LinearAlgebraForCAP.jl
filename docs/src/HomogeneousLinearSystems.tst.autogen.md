
```jldoctest
julia> using MatricesForHomalg, CAP, MonoidalCategories, LinearAlgebraForCAP

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

julia> QQ_mat.cached_precompiled_functions.MereExistenceOfSolutionOfLinearSystemInAbCategory( QQ_mat, alpha, beta, gamma )
true

julia> QQ_mat.cached_precompiled_functions.MereExistenceOfUniqueSolutionOfLinearSystemInAbCategory( QQ_mat, alpha, beta, gamma )
false

julia> x = QQ_mat.cached_precompiled_functions.SolveLinearSystemInAbCategory( QQ_mat, alpha, beta, gamma );

julia> (1*7)/QQ * x[1] + (2*8)/QQ * x[2] + (3*9)/QQ * x[3] == gamma[1]
true

julia> (4*3)/QQ * x[1] + (5*4)/QQ * x[2] + (6*1)/QQ * x[3] == gamma[2]
true

julia> QQ_mat.cached_precompiled_functions.MereExistenceOfUniqueSolutionOfHomogeneousLinearSystemInAbCategory( QQ_mat, alpha, beta )
false

julia> B = QQ_mat.cached_precompiled_functions.BasisOfSolutionsOfHomogeneousLinearSystemInLinearCategory( QQ_mat, alpha, beta );

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

julia> QQ_mat.cached_precompiled_functions.MereExistenceOfSolutionOfLinearSystemInAbCategory( QQ_mat, alpha, beta, gamma )
true

julia> QQ_mat.cached_precompiled_functions.MereExistenceOfUniqueSolutionOfLinearSystemInAbCategory( QQ_mat, alpha, beta, gamma )
true

julia> x = QQ_mat.cached_precompiled_functions.SolveLinearSystemInAbCategory( QQ_mat, alpha, beta, gamma );

julia> (1*7)/QQ * x[1] + (2*8)/QQ * x[2] + (3*9)/QQ * x[3] == gamma[1]
true

julia> (4*3)/QQ * x[1] + (5*4)/QQ * x[2] + (6*1)/QQ * x[3] == gamma[2]
true

julia> (2*5)/QQ * x[1] + (3*7)/QQ * x[2] + (9*2)/QQ * x[3] == gamma[3]
true

julia> QQ_mat.cached_precompiled_functions.MereExistenceOfUniqueSolutionOfHomogeneousLinearSystemInAbCategory( QQ_mat, alpha, beta )
true

julia> B = QQ_mat.cached_precompiled_functions.BasisOfSolutionsOfHomogeneousLinearSystemInLinearCategory( QQ_mat, alpha, beta );

julia> Length( B )
0

julia> alpha = [ [ 2/QQ * id_t, 3/QQ * id_t ] ];

julia> beta = [ [ 1/QQ * id_t, 1/QQ * id_t ] ];

julia> gamma = [ [ 1/QQ * id_t, 1/QQ * id_t ] ];

julia> delta = [ [ 3/QQ * id_t, 3/QQ * id_t ] ];

julia> B = QQ_mat.cached_precompiled_functions.BasisOfSolutionsOfHomogeneousDoubleLinearSystemInLinearCategory( QQ_mat, alpha, beta, gamma, delta );

julia> Length( B )
1

julia> mor1 = PreCompose( alpha[1][1], B[1][1] ) + PreCompose( alpha[1][2], B[1][2] )
<A morphism in Category of matrices over Q>

julia> mor2 = PreCompose( B[1][1], delta[1][1] ) + PreCompose( B[1][2], delta[1][2] )
<A morphism in Category of matrices over Q>

julia> mor1 == mor2
true

```
