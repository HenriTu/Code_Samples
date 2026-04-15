from ai_handler import AIHandler
from pathlib import Path
from image_editing import blogger_safe_denoise, convert_png_to_jpg
from file_handling import dict_to_txt_file
import os


def generate_blog_posts(subjects: list[dict], ai_handler: AIHandler):
    """Generates blog posts and associated images based on the provided subjects and AI handler."""
    
    blog_posts_folder = os.getenv("BLOG_POSTS_FOLDER")
    Path(blog_posts_folder).mkdir(exist_ok=True)
    generate_images: bool = True if os.getenv("GENERATE_IMAGES") == "Yes" else False

    for subject in subjects:
        blog_post: dict = ai_handler.generate_blog_post(subject["subject"])
        image_texts: dict = ai_handler.generate_image_texts(subject["image_prompt"])
        folder: str = blog_posts_folder + "/" + blog_post["folder"]
        if generate_images:
            image_path: str = ai_handler.generate_image(
                subject["image_prompt"], image_texts["file_name"] + ".png", folder
            )
            blogger_safe_denoise(image_path, image_path)
            convert_png_to_jpg(image_path)
        blog_post_content: dict = {
            "Title": blog_post["title"],
            "Text Body": blog_post["text_body"],
            "Search Description": blog_post["search_description"],
            "Title Text": image_texts["title_text"],
            "Alt Text": image_texts["alt_text"],
            "Permalink": blog_post["permalink"],
        }
        
        dict_to_txt_file(blog_post_content, folder + "/" + "blog_post_content.txt")
