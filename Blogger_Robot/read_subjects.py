from file_handling import load_yaml
from list_operations import split_blog_subject_and_image_prompt
import os

def read_subjects() -> list[dict]:
    """Reads the subjects from a YAML file specified by the environment variable SUBJECTS_FILE_NAME."""
    
    subjects: list[str] = load_yaml(os.getenv("SUBJECTS_FILE_NAME"))
    subjects: list[dict] = split_blog_subject_and_image_prompt(subjects)

    return subjects

