function I = simpcomp(a, b, M, f)
% SIMPCOMP Formula di Simpson composita.
%
%   I = simpcomp(a, b, M, f)
%
% Inputs:
%    a, b: estremi di integrazione
%    M:    numero di sottointervalli
%    f:    funzione (function handle)
% Output:
%    I: valore approssimato dell'integrale

h = (b - a) / M;                       % ampiezza dei sottointervalli
xestr = a : h : b;                     % estremi dei sottointervalli
xmed  = a + h/2 : h : b - h/2;         % punti medi dei sottointervalli

yestr = f(xestr);
ymed  = f(xmed);

I = (h/6) * ( yestr(1) + 2*sum(yestr(2:end-1)) + yestr(end) + 4*sum(ymed) );
end
