# MkDocs to Docset

This is forked from Matt Walkers unofficial [docker-docs](https://github.com/MWers/docker-docset/) to Docset.

I searched for a straightforward way to convert a MkDocs folder to Docset. The build.sh script inherits its use as Makefile from the former Dockerfile. The other work gets done by Matts Python scripts in bin/.

I was out of luck with [doc2dash](https://github.com/hynek/doc2dash) going the Markdown->Sphinx->Docset route. Even if you pin remarkcommon Version via pip(0.5.4), you will run into the problem of Sphinx not including .md files from the mkdocs.yml Table of Contents. Or so it seemed. But you can get there, only the TOC was lacking.

Thanks to Matt for providing an alternative.

---- 

# Setup

Place your mkdocs.yml file and docs/ folder in the basedir of the Repo.

## Customize

You might want to change the logos in assets/

Edit DOCSET_NAME in build.sh to your desired name. Check if the cleanup "rm -rf" fit your editing needs.

## Build Docset

```
./build.sh
```

## Copy your .docset to the local filesystem

For Zeal users:

```
cp -R release/*.docset/ ~/.local/share/Zeal/Zeal/docsets/
```

Dash.app users should be able to install via the generated .tgz file.

## Troubleshooting

The build.sh scripts calls python3 - so you want to have that symlink working. Tested on Ubuntu trusty/xenial.

If your mkdocs.yml uses the deprecated notation for the "pages", use Matts original bin/yaml2sqlite.py with python2. That was the only caveat I actually ran into.

Example:

```
- pages:
   - ['index.md', 'Index']
```

today:

```
- pages:
   - Index: index.md
```

For the right nav sidebar links to work in Zeal/Dash, you'll need `use_directory_urls: false` in your mkdocs.yml, or hide the sidebar altogether with the inclusion of extra_css in the mkdocs.yml (example for the readthedocs theme):

```
- extra_css:
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

