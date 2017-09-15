function ret = CheckOrtogonal(A)

tic
ret = 0;
if A.' * A == eye(size(A))
	ret = 1;
end
toc