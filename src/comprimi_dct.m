function img_compressa = comprimi_dct(img, F, d)
% COMPRIMI_DCT Compressione tipo JPEG di una immagine in toni di grigio.
%
%   img : matrice 
%   F   : ampiezza dei macro-blocchi
%   d   : soglia di taglio frequenze, 0 <= d <= 2F-2
%
    % Divisione in blocchi, scartando gli avanzi
img = double(img);
[H, W] = size(img);
    
    % Controlli sugli input
if F <= 0 || F ~= floor(F)
    error('F deve essere un intero positivo.');
end
 
if F > H || F > W
    error('F deve essere minore o uguale alle dimensioni dell''immagine.');
end
 
if d < 0 || d > 2*F - 2 || d ~= floor(d)
    error('d deve essere un intero compreso tra 0 e 2F-2.');
end
 
    %Approssimo per difetto
n_r = floor(H / F);
n_c = floor(W / F);
H_eff = n_r * F;
W_eff = n_c * F;
 
img_crop = img(1:H_eff, 1:W_eff);
img_compressa = zeros(H_eff, W_eff);
 
    % Elaborazione blocco per blocco
for ir = 1:n_r
    for ic = 1:n_c
        
        %indici
        r0 = (ir-1)*F + 1;
        c0 = (ic-1)*F + 1;
        
        %prendo blocco FxF (-1 per avere esattamenet F elementi)
        blocco = img_crop(r0:r0+F-1, c0:c0+F-1); 
 
        % DCT2 home-made
        C = dct2_homemade(blocco);
 
        % Taglio frequenze:
        % la traccia usa frequenze da 0 a F-1,
        % mentre MATLAB indicizza da 1 a F.
        for k = 1:F
            for l = 1:F
                if (k-1) + (l-1) >= d
                    C(k,l) = 0;
                end
            end
        end
 
        % IDCT2 
        ff = idct2(C);
 
         % Arrotondamento e restrizione in [0,255]
        ff = round(ff);
        ff(ff < 0) = 0;
        ff(ff > 255) = 255;
 
        % Ricompongo il blocco nell'immagine finale
        img_compressa(r0:r0+F-1, c0:c0+F-1) = ff;
 
    end
end
% Visualizzazione immagine originale e compressa affiancate
figure
 
subplot(1,2,1)
imshow(uint8(img))
title('Immagine originale')
 
subplot(1,2,2)
imshow(uint8(img_compressa))
title('Immagine compressa')
end
 