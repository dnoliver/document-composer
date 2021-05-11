#/bin/sh

set -euo pipefail
echo "### Creating build directory"
rm -fr ./build && mkdir ./build/ 
echo "### Adding Citations to Content"
node ./citations.js < ./Content.md > build/Content.md
echo "### Generating Content.docx"
pandoc --toc -V toc-title:"Table of Contents" \
    --reference-doc=./reference.docx \
    --highlight-style=./snippet.theme \
    --output ./build/Content.docx \
    build/Content.md \
    ./Final.md
echo "### Copying Cover.docx"
cp ./Cover.docx ./build/
echo "### Generating Document.docx"
python3 document_composer.py \
    --cover "build/Cover.docx" \
    --body "build/Content.docx" \
    --output "build/Document.docx"