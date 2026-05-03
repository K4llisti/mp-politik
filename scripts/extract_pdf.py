from pypdf import PdfReader
import sys

def extract_text(pdf_path):
    try:
        reader = PdfReader(pdf_path)
        print(f"TOTAL_PAGES:{len(reader.pages)}")
        for i, page in enumerate(reader.pages):
            print(f"---PAGE_{i+1}---")
            print(page.extract_text())
    except Exception as e:
        print(f"ERROR:{str(e)}")

if __name__ == "__main__":
    extract_text(sys.argv[1])
