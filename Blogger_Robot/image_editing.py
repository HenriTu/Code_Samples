from PIL import Image
from skimage.util import img_as_float, img_as_ubyte
from skimage.restoration import denoise_nl_means, estimate_sigma
import numpy as np
import os

def blogger_safe_denoise(input_path, output_path):
    """
    Load an image, denoise it using Non-Local Means, and save without metadata.
    """
    
    # Open image and convert to RGB
    img = Image.open(input_path).convert("RGB")
    
    # Convert to float image for skimage
    img_np = img_as_float(np.array(img))
    
    # Estimate noise standard deviation for color image
    sigma_est = np.mean(estimate_sigma(img_np, channel_axis=-1))
    
    # Denoise with Non-Local Means
    denoised = denoise_nl_means(
        img_np,
        h = 2.5 * sigma_est,
        fast_mode = True,
        patch_size = 5,
        patch_distance = 3,
        channel_axis = -1  # handle RGB properly
    )
    
    # Convert back to 8-bit image
    denoised_img = Image.fromarray(img_as_ubyte(denoised))
    
    # Save image without metadata / EXIF
    denoised_img.save(output_path, format="PNG")

def convert_png_to_jpg(file_path: str):
    """Convert a PNG image to JPG."""

    # Open the PNG image
    png_image = Image.open(file_path)

    # Convert to RGB (JPEG does not support transparency)
    jpg_image = png_image.convert("RGB")

    base, _ = os.path.splitext(file_path)
    output_path = f"{base}.jpg"

    # Save as JPG
    jpg_image.save(output_path, "JPEG")

