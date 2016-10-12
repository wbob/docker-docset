# MkDocs to Docset

This is forked from Matt Wers unofficial docker-docs to Docset [Repo](https://github.com/MWers/docker-docset/).

I searched for a straightforward way to convert a MkDocs folder to Docset and found this in his Python and extracted build.sh scripts from its Dockerfile.

Preliminary I was out of luck with [doc2dash](https://github.com/hynek/doc2dash) going the Markdown->Sphinx->Docset route. Even if you pin remarkcommon Version via pip(0.5.4), you will run into the problem of Sphinx not including .md files from the mkdocs.yml Table of Contents. Or so it seemed.

Thanks to Matt for providing an alternative.

---- 

# Setup

Place your mkdocs.yml file and docs/ folder in the basedir of the Repo.

## Customize

You might want to change the logos in assets/icon.png

## Build Docset

```
./build.sh
```

## Copy your .docset to the local filesystem

For Zeal users:

```
cp -R release/*.docset/ ~/.local/share/Zeal/Zeal/docsets/
```

Dash could probably install via the generated .tgz file in release/

## Troubleshooting

The build.sh scripts calls python2 - so you might want to have that symlink working.

If your mkdocs.yml uses the deprecated notation for toc update, use the Matts original bin/yaml2sqlite.py script.

```
- pages:
   - ['index.md', 'Index']
```

today:

```
- pages:
   - Index: index.md
```

For the right nav sidebar links to work, you'll need `use_directory_urls: false` in your mkdocs.yml

Or hide the sidebar alltogether (in case of readthedocs theme):

```
extra_css:
   - css/docset.css
```

```
$ cat css/docset.css 
.wy-nav-content-wrap { margin-left: 0;}
.wy-nav-side { display: none; }
.rst-versions { display: none; }
```
