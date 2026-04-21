import os
import re

def clean_imports(directory):
    # Regex to match the unnecessary imports
    # We want to match both single and double quotes
    patterns = [
        re.compile(r"^import\s+['\"]package:flutter_animate/flutter_animate.dart['\"];\s*$"),
        re.compile(r"^import\s+['\"]package:font_awesome_flutter/font_awesome_flutter.dart['\"];\s*$")
    ]

    for root, dirs, files in os.walk(directory):
        for file in files:
            if file.endswith('.dart'):
                file_path = os.path.join(root, file)
                
                # Skip the barrel file itself if it's in this directory
                if file == 'imports.dart':
                    continue
                    
                with open(file_path, 'r', encoding='utf-8') as f:
                    lines = f.readlines()
                
                new_lines = []
                changed = False
                for line in lines:
                    is_redundant = False
                    for p in patterns:
                        if p.match(line.strip()):
                            is_redundant = True
                            break
                    
                    if is_redundant:
                        changed = True
                    else:
                        new_lines.append(line)
                
                if changed:
                    with open(file_path, 'w', encoding='utf-8') as f:
                        f.writelines(new_lines)
                    print(f"Cleaned {file_path}")

if __name__ == "__main__":
    lib_dir = os.path.join(os.getcwd(), 'lib')
    if os.path.exists(lib_dir):
        clean_imports(lib_dir)
    else:
        print("lib directory not found")
