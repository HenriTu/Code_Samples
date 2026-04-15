def split_blog_subject_and_image_prompt(items: list[str]) -> list[dict]:
    """
    Splits each item in the list into a subject and an image prompt based on the '|' separator,
    and returns a list of dictionaries with 'subject' and 'image_prompt' keys.
    """
    
    result: list[dict] = []
    for item in items:
        subject, image_prompt = item.split("|")
        result.append(
            {"subject": subject.strip(), "image_prompt": image_prompt.strip()}
        )

    return result
