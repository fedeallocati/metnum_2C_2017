function ret = CheckOrtogonal(A)

tic
ret = 0;
[m, n] = size(A);
if A.' * A == eye(m,n)
	ret = 1;
end
toc