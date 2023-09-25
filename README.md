# LaTeX thesis template

A PhD thesis template with a simple one-column design. See an [example](thesis_final.pdf).

Features:

* Draft mode with to-do notes, word count and other features to help with writing, see [example](thesis_draft.pdf).
* Support for single- or double-sided theses.
* PDF mode to format for on-screen reading, see [example](thesis_pdf.pdf).
* The thesis builds automatically when you push to GitHub.

:information_source: The class complies with the May 2023 Newcastle University thesis [requirements](https://www.ncl.ac.uk/media/wwwnclacuk/studentprogress/files/pgr/202324/Guideline%20for%20Submission%20and%20Format%20of%20Theses%20May23.pdf) as set out [below](#formatting). Another option for Newcastle University theses is the [NUTT](https://github.com/AndreGuerra123/NUTT) template (based on the popular [CUED](https://github.com/kks32/phd-thesis-template) template). This has extra formatting options but, in my view, doesn't look as good.[^1]
[^1]: Largely due to the use of [Times New Roman](https://practicaltypography.com/times-new-roman-alternatives.html)

## Instructions

1. Download the `simple-thesis.zip` template from [Releases](https://github.com/philipdarke/simple-thesis/releases/latest).
2. Update the [package options](#package-package-options) and *PhD details* section of `thesis.tex`.
3. Start writing! Keep each chapter in a directory named `chapterX` (do the same for any appendices). Figures and images should go in `figures` or `images` sub-directories.
4. Add each chapter and appendix to `thesis.tex` using `\input{}` commands.
5. Build the PDF by running `make`.

If you have issues building the PDF locally, try first running `make purge` or see [below](#computer-building-the-pdf-locally).

### :octocat: Using Git

Recommended!

1. Run `git init` in your thesis directory to set up Git.
1. Commit your changes.
1. Create an empty private repository on GitHub for your thesis.
1. Follow the instructions to set up a remote and push your work to GitHub.
1. Make and push regular commits to back up your work. **The PDF will build each time you push to GitHub. Go to Actions, choose the most recent commit and click `thesis-[TIMESTAMP]` under Artifacts to download the PDF.**

## Using the template

### :package: Package options

Option | Description
------ | -----
`oneside` | Double-sided is the default. Use the `oneside` option for a single-sided thesis.
`draft` | Use the `draft` option to add a word count, line numbers etc and enable to-do notes. Remove the draft option to create the final thesis for printing.
`pdf` | You may wish to also disseminate your thesis as a PDF. Use the `pdf` option to format the thesis for reading on screen. Hyperlinks are shown in blue, pages with landscape tables/figures are rotated and blank pages inserted in two-sided theses are marked *This page is intentionally blank*. Margins are equalised to remove the binding edge.

### :blue_book: Thesis formatting

The class includes a number of packages I find useful to typeset documents. See chapter one in the [example thesis](thesis_draft.pdf) for more information.

### :spiral_notepad: To-do notes

To-do notes can be added using:

* `\todonote{}` to create a to-do
* `\reference{}` to note a missing reference
* `\issue{}` to highlight a problem
* `\misc{}` for a miscellaneous note

When the `draft` package option is used, to-do notes are summarised on the first page, see [example thesis](thesis_draft.pdf). All to-do notes are disabled when producing the final thesis.

### :computer: Building the PDF locally

The `Makefile` has been tested on Ubuntu[^2] and MacOS[^3]. It uses `latexmk` to automate the build with the `pdflatex` engine and `biber` for references. If you are unable to use `make` or `latexmk`, or prefer to use a recipe in Visual Studio Code or TeXStudio, follow the instructions below.
[^2]: Ubuntu 18.04, 20.04 and 22.04 with TexLive installed using `sudo apt install texlive-full`
[^3]: MacOS 12 Monterey and 13 Ventura with MacTeX installed using `brew install --cask mactex-no-gui`

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

## Building standalone chapters

To build a standalone chapter (for example to share with your supervisors) place a stub file `chapterX-standalone.tex` in the chapter directory. See `chapter1/chapter1-standalone.tex` for an example. Run `make standalone` to build a PDF for each stub file.

## Formatting

All formatting can be updated in `simple-thesis.cls`.

### Font

* Body text is 12pt.
* Captions and footnotes are smaller to distinguish them from body text[^4].
[^4]: This is a departure from Newcastle University requirements which state "All text should be 12-point except for headings"

### Layout

* 2cm margins with 3cm along the binding edge.
* Text is fully justified in a single column.
* One-and-a-half spacing between lines except for footnotes and quotes which are single spaced.

### Pagination

* Preliminary pages are numbered in lower case Roman numerals.
* Pages from Chapter 1 onwards are numbered in Arabic.

### Headings

* Chapters begin on a new page.
* Chapter headings are 14pt bold in Title Case[^5] and center-aligned.
* Section headings are 12pt bold in Title Case[^5] and left-aligned.
* Sub-section headings are 12pt italic bold and left-aligned.
[^5]:`\thesischapter` and `\thesissection` commands must be used to convert titles to Title Case

### Figures and tables

* Figures and tables are numbered within chapters.

### Header and footer

* Current chapter and section are included in the header.
* Page numbers are centered in the footer.

## Advanced notes on GitHub

It is not possible to directly clone a public GitHub repository to a private one. To use a private repository for your thesis whilst retaining the ability to pull future changes made to the template:

1. Run `git clone --bare git@github.com:philipdarke/simple-thesis.git` to create a bare clone of the repository using SSH[^6].
1. Create an empty private repository on GitHub for your thesis.
1. Mirror push the cloned repository to your private repository using `git push --mirror git@github.com:user/new-repository.git`.
1. Delete the cloned repository and clone your private repository. Use this to write your thesis.
1. Add a remote to the public repository using `git remote add public git@github.com:philipdarke/simple-thesis.git`.
[^6]: HTTPS also works.

To pull any changes made to the template run `git fetch public main` and `git rebase public/main`. You will need to handle conflicts. To push changes to your private repository run `git push [origin remote]` as normal.

:warning: I wouldn't recommend this approach unless you are confident it's right for you.

## License

Made available under the [MIT License](LICENSE).
