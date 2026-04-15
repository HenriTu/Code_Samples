from dotenv import load_dotenv
from ai_handler import AIHandler
from connect_to_open_ai import connect_to_open_ai
from read_subjects import read_subjects
from generate_blog_posts import generate_blog_posts


def main():
    load_dotenv()
    subjects: list[dict] = read_subjects()
    ai_handler: AIHandler = connect_to_open_ai()
    generate_blog_posts(subjects, ai_handler)
        
if __name__ == "__main__":
    main()