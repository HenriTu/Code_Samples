import yaml

def dict_to_txt_file(data_dict: dict, file_path: str, separator_characters=67):
    """Writes a dictionary to a text file with formatted sections."""

    separator: str = "-" * separator_characters  # separator line
    sections: list[str] = []

    for key, value in data_dict.items():
        sections.append(f"##### {key} #####\n\n{value}")

    # Join all sections with the separator
    content: str = f"\n\n{separator}\n\n".join(sections)

    with open(file_path, "w", encoding="utf-8") as file:
        file.write(content + "\n")  # Add a new line at the end

def load_yaml(file_path) -> dict:
    """Loads a YAML file and returns its content as a dictionary."""
    
    with open(file_path) as file:
        content = yaml.safe_load(file)

    return content