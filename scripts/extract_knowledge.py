#!/usr/bin/env python3
import sys
import os
import pdfplumber

def extract_pdf_to_md(pdf_path, output_path):
    print(f"Extracting {pdf_path} to {output_path}...")
    try:
        with pdfplumber.open(pdf_path) as pdf:
            content = []
            content.append(f"# Raw Knowledge: {os.path.basename(pdf_path)}\n")
            content.append(f"> Source: {pdf_path}\n")
            content.append(f"> Total Pages: {len(pdf.pages)}\n\n")
            
            for i, page in enumerate(pdf.pages):
                text = page.extract_text()
                if text:
                    content.append(f"## Page {i+1}\n")
                    content.append(text + "\n")
            
            with open(output_path, 'w', encoding='utf-8') as f:
                f.write("\n".join(content))
        return True
    except Exception as e:
        print(f"Error extracting {pdf_path}: {e}")
        return False

if __name__ == "__main__":
    if len(sys.argv) < 3:
        print("Usage: python3 extract_knowledge.py <input.pdf> <output.md>")
        sys.exit(1)
    
    extract_pdf_to_md(sys.argv[1], sys.argv[2])
