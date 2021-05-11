"""Merge a cover and a body into a composed document"""

import argparse
import time
import sys
from docxcompose.composer import Composer
from docx import Document as Document_compose

parser = argparse.ArgumentParser()
parser.add_argument("-c", "--cover", help="Cover docx file name", default="cover.docx")
parser.add_argument("-b", "--body", help="Body docx file name", default="body.docx")
parser.add_argument("-o", "--output", help="Output docx file name", default="final.docx")
args = parser.parse_args()
FINISHED = False
TRY_COUNTER = 20
while not FINISHED:
    try:
        cover = Document_compose(args.cover)
        body = Document_compose(args.body)
        composer = Composer(cover)
        composer.append(body)
        composer.save(args.output)
        FINISHED=True

    except PermissionError as exception_thrown:
        print("Files not ready yet-")
        TRY_COUNTER -= 1
        if TRY_COUNTER == 0:
            print("Document Composer Script failed - {}".format(exception_thrown))
            sys.exit(1)

        time.sleep(3)
