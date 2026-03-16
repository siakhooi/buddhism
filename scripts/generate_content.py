#!/usr/bin/env python3
import argparse
import yaml
import os
from pypinyin import pinyin, Style, load_phrases_dict


def generate_pinyin(text, custom_dict):
    if custom_dict:
        load_phrases_dict(custom_dict)

    pinyin_text = pinyin(text, style=Style.TONE, heteronym=False)

    output=[]
    for i, item in enumerate(pinyin_text):
        char=text[i]
        pychar="".join(item)
        if char == pychar:
            output.append(f"\\py{{{char}}}{{}}")
        else:
            output.append(f"\\py{{{char}}}{{{pychar}}}")

    return output

def main():
    parser = argparse.ArgumentParser(description='Generate pinyin from source files.')
    parser.add_argument('configDirectory', type=str, help='Path to the config directory')
    parser.add_argument('sourceDirectory', type=str, help='Path to the source directory')
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

    target_output_file=f"{source_dir}/content.tex"

    for file in book_config["files"]:
        filename=file["name"]
        pinyin = file.get("pinyin", True)
        file_path = os.path.join(source_dir, filename)

        if not os.path.exists(file_path):
            print(f"Warning: source file '{file_path}' not found. Skipping.")
            continue

        with open(file_path, encoding="utf-8") as f:
            text = f.read()

        with open(target_output_file, "w", encoding="utf-8") as out_f:
            if pinyin==False:
                    out_f.write(text)
            else:
                on_verse=False
                for line in text.splitlines():

                    if line.strip() == "":
                        out_f.write("\n")

                    elif line.startswith("# "):
                        value=generate_pinyin(line[2:].strip(), custom_dict)
                        out_f.write(f"\\section{{{''.join(value)}}}")
                        out_f.write("\n")

                    elif line.startswith("## "):
                        value=generate_pinyin(line[3:].strip(), custom_dict)
                        out_f.write(f"\\subsection{{{''.join(value)}}}")
                        out_f.write("\n")

                    elif line.startswith("### "):
                        value=generate_pinyin(line[4:].strip(), custom_dict)
                        out_f.write(f"\\subsubsection{{{''.join(value)}}}")
                        out_f.write("\n")

                    elif line=="[[":
                        out_f.write("\\begin{verse}")
                        out_f.write("\n")
                        on_verse=True

                    elif line=="]]":
                        out_f.write("\\end{verse}")
                        on_verse=False
                        out_f.write("\n")

                    else:
                        if on_verse:
                            out_f.write("\n".join(generate_pinyin(line, custom_dict)))
                            out_f.write("\\\\\n")
                        else:
                            out_f.write("\n".join(generate_pinyin(line, custom_dict)))
                            out_f.write("\\\\\n")

if __name__ == '__main__':
    main()
