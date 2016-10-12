# MkDocs to Docset

This is forked from Matt Wers unofficial docker-docs to Docset [Repo](https://github.com/MWers/docker-docset/).

I searched for a straightforward way to convert a MkDocs folder to Docset and found this in his Python and extracted build.sh scripts from its Dockerfile.

Preliminary I was out of luck with [doc2dash](https://github.com/hynek/doc2dash) going the Markdown->Sphinx->Docset route. Even if you pin remarkcommon Version via pip(0.5.4), you will run into the problem of Sphinx not including .md files from the mkdocs.yml Table of Contents. Or so it seemed.

Thanks to Matt for providing an alternative.

---- 

# Setup

Place your mkdocs.yml file and docs/ folder in the basedir of the Repo.

## Customize

You might want to change the logos in assets/icon.png.

Edit the first line in build.sh for DOCSET_NAME to your chosen name.

## Build Docset

```
./build.sh
```

## Copy your .docset to the local filesystem

For Zeal users:

```
cp -R release/*.docset/ ~/.local/share/Zeal/Zeal/docsets/
```

Dash could probably install via the generated .tgz file

## Troubleshooting

The build.sh scripts calls python3 - so you might want to have that symlink working.

If your mkdocs.yml uses the deprecated notation for toc update, use the Matts original bin/yaml2sqlite.py (with python2).

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

# Links

As I read into the Issues of MkDocs, this Link came up:

    - [mkdocs-pandoc](https://github.com/jgrassler/mkdocs-pandoc): Maybe there's a simpler build pipeline waiting for you
