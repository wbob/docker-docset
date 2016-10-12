#!/usr/bin/env bash

rm -rf site && rm -rf release

mkdocs build && \
rm -f site/search_content.json && \
python3 bin/abs2rel.py -v site && \
find site -name "*.html" -exec python3 bin/add-dash-anchors.py {} -v \; && \

mkdir -p release/Devdocs.docset/Contents/Resources/Documents && \
cp -a site/* release/Devdocs.docset/Contents/Resources/Documents && \
python3 bin/yaml2sqlite.py -v mkdocs.yml release/Devdocs.docset/Contents/Resources/docSet.dsidx && \

cp assets/docset/icon@2x.png release/Devdocs.docset/icon@2x.png
cp assets/docset/icon.png release/Devdocs.docset/icon.png
cp assets/docset/Info.plist release/Devdocs.docset/Contents/Info.plist

cd release
tar -cvzf Devdocs.tgz Devdocs.docset
