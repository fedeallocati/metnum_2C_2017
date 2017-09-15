function ret = CheckOrtogonal(A)

tic
ret = 0;
if all(abs((A.' * A) - eye(size(A))) < 1e-4)
	ret = 1;
end
toc