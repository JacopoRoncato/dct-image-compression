[README.md](https://github.com/user-attachments/files/33210473/README.md)

# DCT Image Compression — Numerical Computing in MATLAB

A numerical computing project developed for **Fondamenti di Calcolo Numerico (Numerical Analysis)** at **Politecnico di Milano (2026)**. It explores truncated Fourier series, the Discrete Cosine Transform (DCT), and block-based, JPEG-like grayscale image compression, with a comparison between a custom two-dimensional DCT and MATLAB's optimized implementation.

## Project overview

The project consists of three parts:

1. **Truncated Fourier series:** Approximation of three periodic functions using 15 Fourier harmonics. Fourier coefficients are computed with composite Simpson quadrature, and approximation errors and coefficient norms are evaluated. For the third function, results using 10 and 100 Simpson subintervals are compared graphically.
2. **Discrete Cosine Transform:** Calculation of 1D DCT coefficients for two sampled functions, reconstruction after discarding 60 of 100 transform coefficients, and implementation of a custom 2D DCT. The custom implementation is validated against a reference 8 × 8 block and benchmarked against MATLAB's built-in `dct2`.
3. **JPEG-like image compression:** Grayscale images are split into square blocks, transformed using the 2D DCT, and reconstructed after removing high-frequency coefficients. Three test images are used to demonstrate how block size and frequency cutoff affect visual quality.

## Algorithms and methodology

### Fourier approximation

The tested functions are:

- `f1(x) = x`
- `f2(x) = x(1 - x)`
- `f3(x) = x(1 - x) exp(10x)`

The Fourier approximation uses 15 harmonics on `[0, 1]`. Fourier coefficients are integrated numerically using composite Simpson's rule (`simpcomp.m`).

### DCT and performance analysis

The script builds a DCT transform matrix using `compute_D.m` and computes the 2D transform with `dct2_homemade.m`. Benchmarks compare this implementation with MATLAB's built-in `dct2` on square matrices of increasing sizes, plotting execution times on a logarithmic vertical axis. Separate plots compare observed scaling with the expected reference growth rates **O(N³)** for a matrix-based implementation and **O(N² log N)** for a fast DCT approach. These are theoretical reference curves, not measured complexity proofs.

### Block-based image compression

Each grayscale input image is divided into blocks of size `F × F`. For each block:

1. Compute its 2D DCT.
2. Set to zero the coefficients whose zero-based frequency indices satisfy `k + l >= d`.
3. Apply the inverse DCT.
4. Round and clip pixel intensities to the 8-bit range and reassemble the image.

This is a **JPEG-like frequency-truncation experiment**, not an implementation of the complete JPEG encoding/file format.

| Input image | Block size (`F`) | Frequency cutoff (`d`) |
|---|---:|---:|
| `uma.jpg` | 19 | 6 |
| `deer.jpg` | 82 | 14 |
| `checker.jpg` | 50 | 2 |

## Repository files

| File | Purpose |
|---|---|
| `Progetto_2.m` | Main script, exercises, numerical output and figures |
| `simpcomp.m` | Composite Simpson quadrature |
| `compute_D.m` | Construction of the 1D DCT matrix |
| `dct2_homemade.m` | Custom 2D DCT implementation |
| `comprimi_dct.m` | Block-based grayscale image compression |
| `images/` | Input images, if redistribution is permitted |
| `results/` | Exported plots and compressed images, when available |

The helper-file names above are those called by the main script. They must be present, along with any additional dependencies used internally by the helpers.

## Requirements

- MATLAB with the functions/toolboxes required by `dct2` and the image-processing helpers (commonly the **Image Processing Toolbox**).
- All custom `.m` functions listed above.
- The three input images, if running the compression experiments.

## How to run

1. Clone or download this repository.
2. Open MATLAB and set the current folder to the repository root.
3. Make sure MATLAB can find the helper functions. If necessary, run `addpath(genpath(pwd))`.
4. Place `uma.jpg`, `deer.jpg`, and `checker.jpg` in the **current MATLAB folder** (the main script currently reads them with `imread('filename.jpg')`). Alternatively, update those three `imread` calls to point to `images/`.
5. Run:

   ```matlab
   Progetto_2
   ```

The script prints numerical results and benchmark timings and displays the Fourier and DCT benchmark figures. Export figures and compressed images to `results/` if you want to include them in the repository: the uploaded main script does not itself save those outputs to disk.

## Results and interpretation

- **Fourier approximation:** The script computes maximum approximation errors and the norms of selected sine/cosine coefficient vectors; it compares Simpson quadrature resolutions for the third function.
- **DCT truncation:** Keeping the first 40 of 100 DCT coefficients provides a reconstructed sampled signal whose maximum absolute error is measured.
- **Performance:** The custom DCT2 and MATLAB's built-in DCT2 are timed on increasingly large square matrices. Recorded times depend on the machine and MATLAB version.
- **Image compression:** Discarding higher-frequency coefficients tends to remove fine detail; the visual effect also depends on the block size and structure of the source image. The main script contains qualitative observations for all three test cases.

> Add the exported plots and representative original/compressed image comparisons here once the result files have been saved and checked.

## Notes

This repository documents an educational numerical analysis project. It is not intended as a production image codec. Input images supplied as course materials should only be redistributed if their licensing or permissions allow it.
