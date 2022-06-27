# LaTeX thesis template

A PhD thesis template with a simple one-column design. See an [example](thesis_final.pdf).

Features:

* Draft mode with to-do notes, word count and other features to help with writing, see [example](thesis_draft.pdf).
* Support for single- or double-sided theses.
* PDF mode to format for on-screen reading, see [example](thesis_pdf.pdf).
* The thesis builds automatically when you push to GitHub.

:information_source: The class complies with the August 2019 Newcastle University thesis [requirements](https://www.ncl.ac.uk/media/wwwnclacuk/studentprogress/files/pgr/202122/Guideline%20for%20Submission%20and%20Format%20of%20Theses%20August%202021.pdf) as set out [below](#formatting). Another option for Newcastle University theses is the [NUTT](https://github.com/AndreGuerra123/NUTT) template (based on the popular [CUED](https://github.com/kks32/phd-thesis-template) template). This has extra formatting options but, in my view, doesn't look as good.

## Instructions

1. Download the `simple-thesis.zip` template from [Releases](https://github.com/philipdarke/simple-thesis/releases/latest).
2. Update the [package options](#package-package-options) and *PhD details* section of `thesis.tex`.
3. Start writing! Keep each chapter in a directory named `chapterX` (do the same for any appendices). Figures and images should go in `figures` or `images` sub-directories.
4. Add each chapter and appendix to `thesis.tex` using `\input{}` commands.
5. Build the PDF by running `make`.

If you have issues building the PDF locally, try first running `make purge` or see [below](#computer-building-the-pdf-locally).

Note that GitHub will also build the PDF for you when you push changes, see [below](#octocat-using-git).

### :package: Package options

Option | Description
------ | -----
`oneside` | Double-sided is the default. Use the `oneside` option for a single-sided thesis.
`draft` | Use the `draft` option to add a word count, line numbers etc and enable to-do notes. Remove the draft option to create the final thesis for printing.
`pdf` | You may wish to also disseminate your thesis as a PDF. Use the `pdf` option to format the thesis for reading on screen. Hyperlinks are shown in blue, pages with landscape tables/figures are rotated and blank pages inserted in two-sided theses are marked *This page is intentionally blank*.

### :blue_book: Thesis formatting

The class includes a number of packages I find useful to typeset documents. See chapter one in the [example thesis](thesis_draft.pdf) for more information.

### :spiral_notepad: To-do notes

To-do notes can be added using:

* `\todonote{}` to create a to-do
* `\reference{}` to note a missing reference
* `\issue{}` to highlight a problem
* `\misc{}` for a miscellaneous note

When the `draft` package option is used, to-do notes are summarised on the first
page, see [example thesis](thesis_draft.pdf). All to-do notes are disabled when producing the final thesis.

### :octocat: Using Git

Recommended!

1. Create an empty repository on GitHub for your thesis.
2. Set up Git, commit the template thesis and push to GitHub.
3. Make regular commits to back up your work. **The PDF will build each time you push to GitHub. Go to Actions, choose the most recent commit and click `thesis` under Artifacts to download the PDF.**

### :computer: Building the PDF locally

The `Makefile` has been tested on Ubuntu running TexLive. It uses `latexmk` to automate the build with the `pdflatex` engine and `biber` for references. If you are unable to use `make` or `latexmk`, or prefer to use a recipe in Visual Studio Code or TeXStudio, follow the instructions below.

Run the following to generate the word count files:

```
texcount abstract/* *.tex -sum=1,0,1 -inc -out=wordcount.txt
texcount abstract/* -sum=1,0,1 -1 -out=wordcount.abstract
texcount introduction/* chapter*/* conclusion/* -sum=1,0,1 -brief -out=wordcount.summary
texcount introduction/* chapter*/* conclusion/* -sum=1,0,1 -1 -out=wordcount.total
```

To generate the bibliography, acronyms and index sections run:

```
pdflatex thesis.tex
biber thesis
makeglossaries thesis
makeindex thesis
```

To build the final thesis, you will need to run `pdflatex thesis.tex` at least another two times to add all the sections and update the table of contents.

## Formatting

All formatting can be updated in `simple-thesis.cls`.

### Font

* Body text is 12pt.
* Captions and footnotes are smaller to distinguish them from body text. This is a departure from Newcastle University requirements which state "All text should be 12-point except for headings".

### Layout

* 2cm margins with 3cm along the binding edge.
* Text is fully justified in a single column.
* One-and-a-half spacing between lines except for footnotes and quotes which are single spaced.

### Pagination

* Preliminary pages are numbered in lower case Roman numerals.
* Pages from Chapter 1 onwards are numbered in Arabic.

### Headings

* Chapters begin on a new page.
* Chapter headings are 14pt bold in Title Case* and center-aligned.
* Section headings are 12pt bold in Title Case* and left-aligned.
* Sub-section headings are 12pt italic bold and left-aligned.

\* `\thesischapter` and `\thesissection` commands must be used to convert titles to Title Case

### Figures and tables

* Figures and tables are numbered within chapters.

### Header and footer

* Current chapter and section are included in the header.
* Page numbers are centered in the footer.

## License

Made available under the [MIT License](LICENSE).

