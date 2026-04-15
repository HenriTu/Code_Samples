from openai import OpenAI
from pathlib import Path
from PIL import Image
import json
import random
import base64


class AIHandler:
    """Wrapper for OpenAI API calls used for Blogger automation."""

    def __init__(self, api_key: str):
        """Initialize the client and set up connection to OpenAI."""

        self.open_ai = OpenAI(api_key=api_key)

    def generate_blog_post(self, subject: str, words=500, model="gpt-4o-mini"):
        """
        Generates a blog post based on the given subject and word count,
        following specific content rules and restrictions.
        """

        system_prompt = """
        You are a Blogger assistant specialized in cozy, aesthetic, SEO-friendly lifestyle content.
        Analyze the subject and generate a JSON object ONLY with the keys: "title", "text_body", "search_description", "permalink", "folder".

        CONTENT RULES:
        - Write a warm, descriptive, easy-to-read blog post.
        - Include clear subtitles appropriate for the topic.
        - Maintain SEO best practices: helpful title, keyword-rich introduction, smooth and natural keyword placement.
        - The permalink must be clean, short, lowercase, and hyphen-separated.
        - The search description must be a maximum of 150 characters.
        - The folder key must contain an appropriate Windows folder name for storing the blog content.
        - Format the folder name as lowercase words separated by underscores (e.g., balsam_fir_candles).

        RESTRICTIONS:
        - Output valid JSON only.
        - No explanations outside JSON.
        """

        user_prompt = f"""
        Subject: {subject}
        Words in the body text: {words}

        Return a JSON object exactly as described in the system prompt.
        """

        response = self.open_ai.chat.completions.create(
            model=model,
            messages=[
                {"role": "system", "content": system_prompt},
                {"role": "user", "content": user_prompt},
            ],
            response_format={"type": "json_object"},
        )

        json_as_string = response.choices[0].message.content

        return json.loads(json_as_string)

    def generate_image(self, prompt: str, file_name: str, save_folder: str) -> str:
        """
        Generates an image based on the given prompt,
        saves it to the specified folder with the given file name,
        and returns the image path.
        """

        size: str = random.choice(["1024x1024", "1024x1536"])
        response = self.open_ai.images.generate(
            model="gpt-image-1-mini", prompt=prompt, size=size
        )

        image_base64 = response.data[0].b64_json
        image_bytes = base64.b64decode(image_base64)

        save_folder_path = Path(save_folder)
        save_folder_path.mkdir(
            parents=True, exist_ok=True
        )  # Create folders if they don't exist
        image_path = save_folder_path / file_name
        with open(image_path, "wb") as file:
            file.write(image_bytes)

        # Remove metadata
        image = Image.open(image_path)
        image.save(image_path, "PNG")

        return str(image_path.resolve())

    def generate_image_texts(self, prompt: str, model="gpt-4o-mini"):
        """
        Generates SEO-optimized alt text, file name,
        and title text for an image based on the given prompt.
        """

        system_prompt = """
        You are a Blogger assistant.
        Analyze the given prompt for image generation and produce a JSON object ONLY.
        The JSON must include the following keys: "alt_text", "file_name", and "title_text".

        Create a SEO-optimized alt text describing the image.
        Create an SEO-friendly file name in lowercase with hyphens (no extension), e.g. "beautiful-morning-sunshine".
        Create a simple, clean SEO-friendly title_text that works as Blogger hover text.
        For example, "Beautiful balsam fir candle for a cozy home".

        Return ONLY the JSON. No explanations, no extra text.
        """

        user_prompt = f"""
        Prompt: {prompt}

        Return a JSON object exactly as described in the system prompt.
        """

        response = self.open_ai.chat.completions.create(
            model=model,
            messages=[
                {"role": "system", "content": system_prompt},
                {"role": "user", "content": user_prompt},
            ],
            response_format={"type": "json_object"},
        )

        json_as_string = response.choices[0].message.content

        return json.loads(json_as_string)
