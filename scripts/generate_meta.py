#!/usr/bin/env python3
import sys
import os
import yaml

def main():
    if len(sys.argv) != 2:
        print("Usage: python generate_meta.py <sourceDirectory>")
        sys.exit(1)

    source_dir = sys.argv[1]
    config_path = os.path.join(source_dir, 'config.yaml')
    meta_path = os.path.join(source_dir, 'meta.tex')

    if not os.path.isfile(config_path):
        print(f"config.yaml not found in {source_dir}")
        sys.exit(1)

    with open(config_path, 'r', encoding='utf-8') as f:
        config = yaml.safe_load(f)

    meta = config.get('meta', {})
    title = meta.get('title', {})
    cbeta = meta.get('cbeta', {})
    pdf = meta.get('pdf', {})

    version = meta.get('version', '')
    version_date = meta.get('versionDate', '')

    # Prepare meta.tex content
    lines = [
        f"\\newcommand{{\\metaAuthor}}{{{meta.get('author', '')}}}",
        f"\\newcommand{{\\metaCbetaId}}{{{cbeta.get('id', '')}}}",
        f"\\newcommand{{\\metaVersion}}{{{version}}}",
        f"\\newcommand{{\\metaVersionDate}}{{{version_date}}}",
        f"\\newcommand{{\\metaTitleShort}}{{{title.get('short', '')}}}",
        f"\\newcommand{{\\metaTitleChinese}}{{{title.get('zh', '')}}}",
        f"\\newcommand{{\\metaTitleSanskrit}}{{{title.get('sa', '')}}}",
        f"\\newcommand{{\\metaPdfTitle}}{{{pdf.get('title', '')}}}",
        f"\\newcommand{{\\metaPdfAuthor}}{{{pdf.get('author', '')}}}",
        f"\\newcommand{{\\metaPdfSubject}}{{{pdf.get('subject', '')}}}",
        f"\\newcommand{{\\metaPdfKeywords}}{{{pdf.get('keywords', '')}}}",
    ]

    with open(meta_path, 'w', encoding='utf-8') as f:
        for line in lines:
            f.write(line + '\n')
    print(f"meta.tex generated at {meta_path}")

if __name__ == "__main__":
    main()
