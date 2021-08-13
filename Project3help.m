m = 100; n = 100 ;
I = rand(m,n,10) ;  % your frames
fr = 1:2:20 ;    % frame time
fri = 2:2:20 ;   % frame time to be inteprolated 
Ii = zeros(m,n,length(fri)) ;   % initiliaze the interpolated frames 
%%interpolation 
for i =1:m
    for j = 1:n
        I_ij = squeeze(I(i,j,:)) ;
        Ii_ij = interp1(fr,I_ij,fri,'spline') ;        
        Ii(i,j,:) = reshape(Ii_ij,1,1,length(fri)) ;
    end
end