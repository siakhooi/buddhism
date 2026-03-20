#!/usr/bin/env python3
import argparse
import yaml
import os
from pypinyin import pinyin, Style, load_phrases_dict


def generate_pinyin(text, custom_dict):
    if custom_dict:
        load_phrases_dict(custom_dict)

    # Get pinyin output
    pinyin_text = pinyin(text, style=Style.TONE, heteronym=False)

    # Flatten pinyin_text to a list of strings
    flat_pinyin = []
    for item in pinyin_text:
        # If item is a list of length > 1, flatten it
        for sub in item:
            flat_pinyin.append(sub)

    # If the lengths don't match, try to fix by splitting grouped punctuations
    if len(flat_pinyin) != len(text):
        new_flat = []
        i = 0
        for sub in flat_pinyin:
            # If this pinyin is a group of punctuations, split it
            if len(sub) > 1 and all(
                c in '，。！？：；、“”‘’（）《》〈〉『』「」—…·.?!,:;"' for c in sub
            ):
                for c in sub:
                    new_flat.append(c)
            else:
                new_flat.append(sub)
        flat_pinyin = new_flat

    # Now, if still not matching, fallback to char itself for missing
    if len(flat_pinyin) != len(text):
        # Pad or truncate to match
        if len(flat_pinyin) < len(text):
            flat_pinyin += [""] * (len(text) - len(flat_pinyin))
        else:
            flat_pinyin = flat_pinyin[: len(text)]

    output = []
    for i, char in enumerate(text):
        pychar = flat_pinyin[i]
        if char == pychar:
            output.append(f"\\py{{{char}}}{{}}")
        else:
            output.append(f"\\py{{{char}}}{{{pychar}}}")

    return output


def main():
    parser = argparse.ArgumentParser(description="Generate pinyin from source files.")
    parser.add_argument(
        "configDirectory", type=str, help="Path to the config directory"
    )
    parser.add_argument(
        "sourceDirectory", type=str, help="Path to the source directory"
    )
    args = parser.parse_args()

    config_dir = args.configDirectory
    source_dir = args.sourceDirectory

    global_dict_path = f"{config_dir}/dict.yaml"
    if os.path.exists(global_dict_path):
        with open(global_dict_path, encoding="utf-8") as f:
            custom_dict = yaml.safe_load(f)
    else:
        custom_dict = {}

    book_dict_path = f"{source_dir}/dict.yaml"
    if os.path.exists(book_dict_path):
        with open(book_dict_path, encoding="utf-8") as f:
            book_dict = yaml.safe_load(f)
        custom_dict.update(book_dict)  # book_dict take precedent

    book_config_path = f"{source_dir}/config.yaml"
    if os.path.exists(book_config_path):
        with open(book_config_path, encoding="utf-8") as f:
            book_config = yaml.safe_load(f)
    else:
        print(f"Error: config file '{book_config_path}' not found.")
        return

    target_output_file = f"{source_dir}/content.tex"
    with open(target_output_file, "w", encoding="utf-8") as out_f:
        for file in book_config["files"]:
            filename = file["name"]
            pinyin = file.get("pinyin", True)
            file_path = os.path.join(source_dir, filename)

            if not os.path.exists(file_path):
                print(f"Warning: source file '{file_path}' not found. Skipping.")
                continue

            print(f"Processing '{file_path}' with pinyin={pinyin}...")

            with open(file_path, encoding="utf-8") as f:
                text = f.read()

            if pinyin == False:
                out_f.write(text)
            else:
                on_verse = False
                for line in text.splitlines():

                    if line.strip() == "":
                        out_f.write("\n")

                    elif line.startswith("# "):
                        value = generate_pinyin(line[2:].strip(), custom_dict)
                        out_f.write(f"\\section{{{''.join(value)}}}")
                        out_f.write("\n")

                    elif line.startswith("## "):
                        value = generate_pinyin(line[3:].strip(), custom_dict)
                        out_f.write(f"\\subsection{{{''.join(value)}}}")
                        out_f.write("\n")

                    elif line.startswith("### "):
                        value = generate_pinyin(line[4:].strip(), custom_dict)
                        out_f.write(f"\\subsubsection{{{''.join(value)}}}")
                        out_f.write("\n")

                    elif line == "[[":
                        out_f.write("\\begin{verse}")
                        out_f.write("\n")
                        on_verse = True

                    elif line == "]]":
                        out_f.write("\\end{verse}")
                        on_verse = False
                        out_f.write("\n")

                    else:
                        if on_verse:
                            out_f.write("\n".join(generate_pinyin(line, custom_dict)))
                            out_f.write("\\\\\n")
                        else:
                            out_f.write("\n".join(generate_pinyin(line, custom_dict)))
                            out_f.write("\\\\\n")


if __name__ == "__main__":
    main()
