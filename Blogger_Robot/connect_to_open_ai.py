from ai_handler import AIHandler
import keyring


def connect_to_open_ai() -> AIHandler:
    """
    Connects to the OpenAI API using the API key stored in the keyring
    and returns an AIHandler instance.
    """

    return AIHandler(keyring.get_password("blogger-bot", "OPEN_AI_API_KEY"))
