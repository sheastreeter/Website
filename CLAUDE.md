# CLAUDE.md — sheastreeter.com

Personal academic website for Shea Streeter (political scientist; research on race,
police violence, and public opinion). This file orients Claude Code on the project's
goals, stack, conventions, and open decisions. Update it as decisions are made.

> **Status (2026-07-02): Scaffolded and rendering.** All core decisions confirmed; the full
> Quarto site is built with real content and verified to render (see §12 for the progress
> log). Not yet: live-browser check of the data page, and the site is not yet pushed to
> GitHub or connected to the domain — those steps require Shea and are laid out in
> `LAUNCH_GUIDE.md`. Remaining content/data items are in §11.

---

## 1. Goals

A fast, accessible, professional site at **sheastreeter.com** with four sections:

1. **Research** — publications, working papers, and projects. Each entry: title,
   coauthors, venue/status, year, abstract, and links (PDF, DOI, replication, preprint).
2. **Teaching** — courses taught, roles, teaching statement, and (optionally) syllabi
   and evaluations.
3. **CV** — a well-formatted HTML CV plus a downloadable, always-current PDF.
4. **Data exploration — police killings** — an interactive page where visitors can
   explore Shea's data on police killings (charts, filters, and ideally a map), with a
   clear methods/sources note and a downloadable dataset.

Secondary goals: a short homepage/bio, a contact method, and easy content updates
(adding a new paper should not require touching layout code).

## 2. Audience

Academic peers, hiring/tenure committees, journalists, students, and the public. The
site should read as credible and rigorous while remaining legible to non-specialists —
especially on the police-killings page, where public readers matter.

## 3. Tech stack — **Quarto (confirmed)**

- **Framework:** Quarto website project. Content authored in `.qmd` files; a `_quarto.yml`
  defines the navbar (Research, Teaching, CV, Data) and site config. Renders to a static
  HTML site.
- **Interactivity:** Observable JS (OJS) cells for the data page — Quarto's native path
  for in-browser interactivity (filters, linked charts, map). Chart libraries: Observable
  Plot for charts, Leaflet (or Observable's mapping) for the map. No separate JS build
  needed; OJS runs client-side.
- **Analysis language:** **R (confirmed)** via Quarto's knitr engine. Data prep and any
  code-generated charts are written in R (tidyverse). Processed, web-ready data for the
  interactive page is produced by a committed R script for reproducibility. Pin R version
  and packages (renv recommended).
- **Styling:** Quarto theming via SCSS (Bootstrap-based). Build a custom brand theme
  (`custom.scss`) with design tokens for the "modern & bold" look (see §5) rather than
  using a stock theme unchanged.
- **Content model:** structured data where it pays off — publications and CV entries in
  YAML/CSV rendered by a small script or listing, so adding a paper means editing data,
  not layout. Quarto "listings" can drive the research page from per-item metadata.
- **Toolchain:** Quarto CLI (pin a version), plus R and/or Python environments documented
  for reproducible renders.

## 4. Hosting & deployment — **GitHub Pages (confirmed)**

- **Host:** GitHub Pages. Deploy via GitHub Actions running `quarto render` on push to
  `main` (preferred, since OJS/compute needs a render step), publishing to the `gh-pages`
  branch or Pages artifact. `quarto publish gh-pages` is the manual fallback.
- **Custom domain:** sheastreeter.com (+ www). A `CNAME` file in the published output
  holds the domain; DNS configured at Namecheap (see §8). Enable "Enforce HTTPS."
- **Render outputs:** commit source `.qmd`; do not hand-edit generated HTML.

## 5. Design — **Modern & bold (confirmed)**

- Stronger color, confident large-scale typography, and visual personality — signals a
  public-facing scholar, not a stock template. Built as a custom Quarto SCSS theme with a
  defined palette, type scale, and spacing tokens.
- The homepage and the data page carry the boldest treatment; content pages (CV,
  publications) stay clean and readable so long text isn't fatiguing.
- Responsive and mobile-first; must look right from phone to wide desktop.
- **Accessibility is a hard requirement:** semantic HTML, WCAG AA color contrast (bold
  color must still pass contrast), keyboard navigation, alt text, and reduced-motion
  support. Charts need text/table fallbacks and must not encode meaning by color alone.
- Light mode by default; dark mode optional (nice-to-have, not v1). Quarto supports a
  light/dark theme pair if we want it.
- Follow the `dataviz` skill for every chart: consistent palette, legends, axes, and
  tooltips as one system. The site palette and chart palette should be one coherent system.

## 6. Content conventions

- **Voice:** Prose written for Shea follows the Streeter voice rules in
  `~/.claude/rules/core-voice.md` (clear topic sentences, active voice, evidence-backed
  claims, the vocabulary ban list). This applies to bio, research summaries, and any
  methods/narrative text on the data page.
- **Publications:** one structured entry per work; templates render citations
  consistently. Support statuses: published, forthcoming, under review, working paper.
- **CV:** single source of truth. Prefer generating the on-page CV and the PDF from the
  same structured data if practical; otherwise keep the PDF export step documented so
  the HTML and PDF never drift.
- **Assets:** images optimized (width-appropriate, modern formats); PDFs in a
  predictable `/public` path.

## 7. Police-killings data page — **fully interactive: charts + filterable map (confirmed)**

Built with OJS in a `.qmd` page. Ship in stages toward the full experience.

- **The dataset:** the **Police Killings and Protest (PKAP)** dataset — Shea's original
  research resource of 3,000+ police-killing cases coded for protest outcomes across
  multiple years. It underpins her book project (§ below) and the Violence and Policing
  Lab. **Actively being built and coded right now**, so the web copy is a versioned
  snapshot, not a live pointer to the working file.
- **Current data on site:** geolocated **2015–2016** files (`data/pkap_geolocated_2015.csv`,
  `..._2016.csv`), ~2,240 real cases. Columns: `id, lat, lon, name, age, gender,
  raceethnicity, month, day, year, streetaddress, city, state, classification,
  lawenforcementagency, armed`. **No protest column yet** — the explorer is built around
  demographics, cause (`classification`), armed status, geography, and time; the protest
  layer and additional years get added as finalized. We publish only designated-public
  variables (the page currently omits `streetaddress`/`lawenforcementagency` from views).
- **Architecture:** an **R** prep step reads the PKAP snapshot and produces a clean,
  web-ready file (CSV/JSON) with only public variables; OJS cells load it and render
  linked, filterable charts + a Leaflet map. Filters (year, geography, demographics) drive
  charts and map together.
- **Data pipeline:** the snapshot and the reproducible R prep script are committed. Document
  source, collection/coding method, coverage window, case definition, and known limitations
  (esp. undercounting) directly on the page. Because the data is being actively coded, note
  the snapshot date/version prominently.
- **Sensitivity:** each row is a real death — present soberly (accurate counts, clear
  denominators, explicit caveats; no sensationalized framing).

### Research context (from CV + 2025 FAR — for accurate placeholder copy)

- **Position:** Assistant Professor, Political Science, University of Michigan (President's
  Postdoctoral Fellow 2019–21). Ph.D. Stanford (2019); B.A. Notre Dame (2011).
- **Agenda:** what determines civilian mobilization after incidents of state violence.
- **Book:** *Private Tragedy, Public Movement: Families and the Demand for Police
  Accountability* — why some police killings spark protest and others don't, centering
  families; three-part theory of grievance, bandwidth, and broadcast; draws on PKAP,
  interviews, and fieldwork.
- **Lab:** founder, **Violence and Policing Lab** (12 students).
- **Key publications:** *Lethal Force in Black and White* (J. of Politics 2019); *Police
  Abuse or Just Deserts?* (POQ 2022, w/ Israel-Trummel); *Bringing Abolition In* (SSQ 2021,
  w/ Davies & Jackson). Working paper: *Mobilization Readiness and the Geography of Protest
  in the 2020 Uprising* (w/ Schuett).
- **Teaching signature:** Politics of Police and Prisons in the U.S. (specifications
  grading redesign); Abolition in Theory and Practice; African Americans and the Politics
  of Race.
- **Sensitivity:** this data concerns real deaths. Present it soberly and precisely —
  accurate counts, clear denominators, no sensationalized framing, and explicit caveats
  about undercounting and data provenance.
- **Features (staged):**
  1. v1 — core charts (trends over time; breakdowns by relevant categories) with filters.
  2. v2 — geographic map with filtering.
  3. v3 — downloadable dataset + codebook, and shareable views.
- **Open questions for Shea:** data format and location, update cadence, which variables
  are public, and whether analysis is authored in R/Python (affects §3).

## 8. Namecheap DNS (for GitHub Pages)

To be finalized once hosting is confirmed. For GitHub Pages with an apex + www domain,
set at Namecheap (Advanced DNS):

- Four `A` records for the apex `@` → GitHub Pages IPs
  (`185.199.108.153`, `185.199.109.153`, `185.199.110.153`, `185.199.111.153`).
- One `CNAME` record: `www` → `<github-username>.github.io`.
- Remove Namecheap's default parking/redirect records.
- In the repo, set the custom domain in Pages settings and enable "Enforce HTTPS."

(Netlify path differs — it uses Netlify nameservers or a CNAME to the Netlify subdomain.)

## 9. Repository layout (planned)

```
/                    project root
  CLAUDE.md          this file
  _quarto.yml        site config: navbar (Research, Teaching, CV, Data), theme
  index.qmd          homepage / bio
  research.qmd       publications (driven by structured metadata / listing)
  teaching.qmd       courses + teaching statement
  cv.qmd             HTML CV (links to downloadable PDF)
  data/
    police-killings.qmd   the interactive data page (OJS cells)
  theme/
    custom.scss      brand theme: palette, type scale, spacing tokens
  _data/             structured content (publications.yml, courses.yml, cv data)
  data-src/          raw police-killings data + reproducible prep scripts (R/Python)
  assets/            processed web-ready data (CSV/JSON), images, CV.pdf
  .github/workflows/ deploy.yml — render + publish to GitHub Pages
```

## 10. Working agreements for Claude

- Core stack is set (Quarto / GitHub Pages / interactive data page / modern-bold). Resolve
  the §11 open items before building the pieces that depend on them.
- Keep content and presentation separate: add a paper by editing data, not layout.
- Prioritize accessibility and performance; avoid heavy dependencies without a reason.
- For any prose, apply the Streeter voice rules.
- Never commit private data or credentials; keep the police-killings dataset's licensing
  and provenance documented.
- Don't push, deploy, or change DNS without explicit confirmation.

## 11. Open questions (to resolve with Shea)

_Core stack decisions are resolved (§3–§5, §7). Remaining:_

_Resolved: stack = Quarto; host = GitHub Pages; data page = fully interactive; design =
modern & bold; analysis language = R; contact = email link only; GitHub = `sheastreeter`._

**Assets & links on hand** (in project root):
- `shea-streeter5.jpg` — headshot.
- `Streeter_CV4_26.pdf` — current CV PDF (the download link on the CV page).
- `Streeter_CV.tex` — CV LaTeX source (structured content to render the HTML CV page from).
  Uses a custom `resume.cls` template class that is **not** in the folder, so recompiling
  the PDF is not currently possible; we render the HTML CV natively in Quarto and link the
  existing PDF. If Shea wants a regenerated PDF, obtain `resume.cls` first.
- **Google Scholar:** https://scholar.google.com/citations?user=q2j799YAAAAJ&hl=en
  (wire into header/footer; ~142 citations as of 2025).

_Placeholder copy for research/teaching/bio to be drafted from the CV + 2025 FAR (see §7
research context) in the Streeter voice._

**Remaining:**
1. **PKAP protest coding + more years:** the current data page runs on real 2015–2016
   geolocated files but has **no protest column yet**; add the protest-outcome variable and
   additional years when ready (drop files into `data/`, add to the `FileAttachment`
   loaders, extend the year filter). Confirm licensing/attribution and a citation for the data.
2. **Content polish:** Shea to review/refine the drafted bio, research abstracts, and
   teaching copy; add a headshot credit if needed.

## 12. Build progress log

**2026-07-02 — Full scaffold complete and rendering.**
- Created Quarto site: `_quarto.yml` (navbar Home/Research/Teaching/CV/Data + Scholar link,
  page footer with obfuscated contact), pages `index/research/teaching/cv.qmd` +
  `data/police-killings.qmd`, bold theme `theme/custom.scss` (palette from the validated
  data-viz reference set).
- Content drafted from CV + 2025 FAR in the Streeter voice (bio, research agenda, 3 articles
  w/ abstracts + DOIs, working papers, teaching philosophy, HTML CV from the `.tex`).
- Email obfuscation: `_includes/email-obfuscation.html` assembles `sashea@umich.edu` from
  split `data-user`/`data-domain` attributes at runtime — verified the full address never
  appears contiguously in rendered HTML.
- Data page: interactive explorer over the **real 2015–2016** geolocated PKAP files
  (`data/pkap_geolocated_2015.csv`, `..._2016.csv`, ~2,240 rows). Leaflet map + Observable
  Plot charts (by month / race-ethnicity / cause) + filterable table; filters = year,
  race/ethnicity, armed status. Synthetic placeholder data was removed once real data arrived.
- Deploy: `.github/workflows/publish.yml` (Quarto render → peaceiris → `gh-pages`,
  `cname: sheastreeter.com`). `CNAME`, `.gitignore` (protects `data-src/*_raw.csv`),
  `data-src/prep_pkap.R`, `README.md` added.
- **Verification done:** `quarto render` succeeds (all 5 pages); YAML front matter valid;
  data columns present + lat/lon numeric; OJS runtime + both CSVs + Leaflet CSS present in
  output; no email leak.
- **Verification NOT done:** live-browser check of OJS charts/Leaflet map (Chrome extension
  not connected). This is the one runtime-untested piece.

**Environment notes for future sessions:**
- **Project location (moved 2026-07-08):** the working copy now lives at
  `C:\Users\sashea\Projects\Website` — **outside Dropbox**. The old Dropbox path
  (`...\Dropbox (Personal)\Academic\Projects\Website`) is a **frozen backup**; do not work in
  it. Reason: Dropbox and Quarto fought over `.quarto`/`_site` (Quarto deletes+recreates them
  each render, Dropbox locks them mid-sync → `os error 32` "file in use", fatal on
  `_freeze`/`idx`/`_site`). Moving out eliminates it; `quarto render` and `quarto preview` both
  run clean in the new location. Delete the Dropbox copy once the site is on GitHub. (If ever
  working inside Dropbox again, the stopgap is a `com.dropbox.ignored=1` alternate-data-stream
  marker on `.quarto`/`_site`, but it's fragile because `_site` is recreated unmarked.)
- Quarto is **installed** at `C:\Users\sashea\AppData\Local\Programs\Quarto\bin\quarto.exe`
  (not always on PATH in non-interactive shells — prepend that dir if `quarto` isn't found).
  The earlier portable-Quarto-in-scratchpad workaround is no longer needed.
- Not yet a git repo; not pushed to GitHub; domain not connected. See `LAUNCH_GUIDE.md`.
```
