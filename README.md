# CudaSLIC: GPU-Accelerated SLIC Superpixel Segmentation

CudaSLIC is a high-performance implementation of the Simple Linear Iterative Clustering (SLIC) algorithm leveraging NVIDIA CUDA for rapid image segmentation. It groups pixels into superpixels based on color similarity and spatial proximity, making it an ideal solution for computer vision applications.

---

## Overview

CudaSLIC uses GPU acceleration to efficiently compute superpixels from an input image. The algorithm partitions the image into clusters that balance color and spatial data, controlled by several user-defined parameters. This implementation is designed with a C-compatible interface for easy integration into larger projects.

---

## Features

- **GPU Acceleration**: Significantly faster segmentation using CUDA.
- **Configurable Parameters**: Control over the number of superpixels, maximum iterations, compactness, and convergence threshold.
- **Simple Integration**: Provides a straightforward C API for easy incorporation into diverse systems.
- **Open-Source**: Licensed under GPL 3.0, ensuring the code remains free and open.

---

## Installation

### Prerequisites

- NVIDIA GPU with CUDA support.
- CUDA Toolkit installed.
- C++ compiler supporting C++11 (or later).

### Building from Source

Clone the repository and build the project using CMake:

```bash
git clone https://github.com/SilverSix6/CudaSLIC.git
cd CudaSLIC
make
```

_Ensure that your system’s CUDA environment is properly configured before building. (See Makefile)_

---

## Usage

The main entry point for performing superpixel segmentation is the `slic` function. This function is defined as follows:

```cpp
/**
 * Performs Superpixel segmentation using the Simple Linear Iterative Clustering (SLIC) algorithm on
 * a given image. The function groups pixels into superpixels based on color and spatial proximity.
 * 
 * @param image: A pointer to the input image. This data should be stored in a 1D array in row-major order. The image is assumed to be RGB.
 * @param width: The image's width (number of pixels).
 * @param height: The image's height (number of pixels).
 * @param num_superpixels: The total number of superpixels the system will produce. 
 * @param max_iterations: The maximum number of iterations to process if the error threshold is not reached.
 * @param m: The compactness factor. Used to balance spatial and color proximity. Higher values enforce spatial uniformity.
 * @param threshold: The stopping threshold for convergence.
 * @param clusters: Pointer to an array of Cluster structs storing cluster centers. Memory should be pre-allocated.
 * @param segmented_matrix: Pointer to the output matrix of the same dimensions as the input image. Each pixel is assigned the id of its superpixel label.
 */
extern "C" void slic(unsigned char* image, int width, int height, int num_superpixels, int max_iterations, float m, float threshold, Cluster *clusters, int *segmented_matrix);
```

### Example Usage

Below is a simple example demonstrating how to use the `slic` function in a C/C++ project:

```cpp
#include "slic.h"  // Ensure this header declares the slic function and Cluster struct

int main() {
    // Load or generate your image data (RGB, row-major order)
    unsigned char* image_data = /* Your image loading function */;
    int width = /* image width */;
    int height = /* image height */;

    // Define SLIC parameters
    int num_superpixels = 400;
    int max_iterations = 10;
    float compactness = 10.0f;
    float threshold = 0.001f;

    // Pre-allocate memory for clusters and segmented matrix
    Cluster* clusters = new Cluster[num_superpixels];
    int* segmented_matrix = new int[width * height];

    // Run the SLIC segmentation
    slic(image_data, width, height, num_superpixels, max_iterations, compactness, threshold, clusters, segmented_matrix);

    // Process or visualize the segmented_matrix as needed

    // Clean up allocated memory
    delete[] clusters;
    delete[] segmented_matrix;

    return 0;
}
```

---

## Contributing

Contributions to CudaSLIC are welcome! If you have ideas for improvements or find bugs, please submit a pull request or open an issue on the [GitHub repository](https://github.com/SilverSix6/CudaSLIC).

---

## License

CudaSLIC is licensed under the [GPL 3.0](LICENSE) license. Please refer to the LICENSE file for more details.

---

## Acknowledgements

CudaSLIC is inspired by the original SLIC algorithm research. Special thanks to the open-source community for continuous support and improvements in GPU-accelerated image processing techniques.

---