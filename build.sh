#!/usr/bin/env bash
DOCSET_NAME='Devdocs'

# prior cleanup
rm -rf site && rm -rf release

mkdocs build && \
rm -f site/search_content.json && \
python3 bin/abs2rel.py -v site && \
find site -name "*.html" -exec python3 bin/add-dash-anchors.py {} -v \; && \
mkdir -p release/"$DOCSET_NAME".docset/Contents/Resources/Documents && \
cp -a site/* release/"$DOCSET_NAME".docset/Contents/Resources/Documents && \
python3 bin/yaml2sqlite.py -v mkdocs.yml release/"$DOCSET_NAME".docset/Contents/Resources/docSet.dsidx && \

# add icons
cp assets/docset/icon@2x.png release/"$DOCSET_NAME".docset/icon@2x.png
cp assets/docset/icon.png release/"$DOCSET_NAME".docset/icon.png
cp assets/docset/Info.plist release/"$DOCSET_NAME".docset/Contents/Info.plist

# create tgz package
tar -cvzf "$DOCSET_NAME".tgz release/"$DOCSET_NAME".docset

# optionally, move docset to Zeal directory and clear prior copy
rm -rf ~/.local/share/Zeal/Zeal/docsets/"$DOCSET_NAME".docset/
cp -R release/"$DOCSET_NAME".docset/ ~/.local/share/Zeal/Zeal/docsets/
