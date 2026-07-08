# sheastreeter.com

Personal academic website for Shea Streeter, built with [Quarto](https://quarto.org)
and deployed to GitHub Pages. See `CLAUDE.md` for full project context and decisions.

## Sections

- **Home** (`index.qmd`) — bio and research overview
- **Research** (`research.qmd`) — publications and working papers
- **Teaching** (`teaching.qmd`) — courses and teaching philosophy
- **CV** (`cv.qmd`) — HTML CV + PDF download
- **Data: Police Killings** (`data/police-killings.qmd`) — interactive PKAP explorer
  (Observable JS charts + Leaflet map)

## Preview locally

Install the [Quarto CLI](https://quarto.org/docs/get-started/), then from this folder:

```bash
quarto preview
```

This opens a live-reloading preview in your browser. To build the static site into
`_site/` without serving it:

```bash
quarto render
```

No R or Python is required to build the site — the pages are Markdown plus
client-side Observable JS. (R is only used offline to prepare the data snapshot.)

## Updating the police-killings data

The explorer loads the geolocated **2015–2016** PKAP records
(`data/pkap_geolocated_2015.csv`, `data/pkap_geolocated_2016.csv`) — real cases with
demographics, circumstances, and location, but not yet the protest-outcome coding. To
extend it:

1. Keep raw working exports in `data-src/` (git-ignored — never committed).
2. Edit `data-src/prep_pkap.R` to select the confirmed public variables (and the protest
   column once finalized).
3. Run `Rscript data-src/prep_pkap.R` to (re)write the public CSVs in `data/`.
4. Add any new year's file to the `FileAttachment(...)` loaders in
   `data/police-killings.qmd`, and extend the year filter.

## Deployment

Pushing to `main` triggers `.github/workflows/publish.yml`, which renders the site and
publishes it to the `gh-pages` branch. The custom domain (`sheastreeter.com`) is set via
the `CNAME` file. DNS is configured at Namecheap — see `CLAUDE.md` §8.
