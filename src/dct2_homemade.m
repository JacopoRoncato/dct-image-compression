function C = dct2_homemade(f)
% DCT2_HOMEMADE DCT2 "fatta in casa" via DCT monodimensionale applicata
% prima alle colonne e poi alle righe, ovvero:
%       C = D_r * f * D_c'

f = double(f);
[nr, nc] = size(f);
Dr = compute_D(nr);
Dc = compute_D(nc);
% Passo 1: DCT lungo le colonne -> trasforma ciascuna colonna
tmp = Dr * f;
% Passo 2: DCT lungo le righe -> trasforma ciascuna riga
C = tmp * Dc';
end
%restituisce una MATRICE