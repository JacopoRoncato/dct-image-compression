function D = compute_D(N)
% COMPUTE_D Matrice della DCT-II ortonormale di dimensione N x N.
% Con questo scaling vale inv(D) = D'.
%
% Formula:
%   D(k,i) = alpha(k) * cos((k-1)*pi*(2i-1)/(2N))
% con  alpha(0) = 1/sqrt(N),  alpha(k) = sqrt(2/N) per k>=1.

alpha_vect = zeros(N, 1);
alpha_vect(1)     = N^(-0.5);
alpha_vect(2:end) = N^(-0.5) * sqrt(2);

D = zeros(N, N);
for k = 1:N
    for i = 1:N
        D(k,i) = alpha_vect(k) * cos((k-1) * pi * (2*i-1) / (2*N));
    end
end
end
