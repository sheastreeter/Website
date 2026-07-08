# Getting sheastreeter.com Live — Your Step-by-Step Guide

This guide covers **only the steps that require you** — installing software on your
computer, logging into your own accounts, and clicking through settings that need your
password. Everything else (writing the website, wiring up the data, fixing code) is already
done or can be handled in a future session with Claude.

**The big picture — three phases:**

1. **Preview** — see the finished website on your own computer.
2. **Publish** — put the website's files on GitHub so they can go online.
3. **Connect the domain** — point sheastreeter.com at the published site.

Budget about **1–2 hours** total, spread over a day (the last step involves some waiting).
You do **not** need to know how to code. Take the phases in order.

---

## A few terms, in plain English

- **Quarto** — the free program that turns the website's source files into web pages. You
  need it installed to preview the site on your computer.
- **GitHub** — a free website where the site's files live and from which they are published
  online. Think of it as Dropbox, but designed for websites and code.
- **Repository ("repo")** — one project's folder on GitHub. Yours will hold the website.
- **GitHub Pages** — GitHub's free service that turns a repository into a live website.
- **GitHub Desktop** — a free app with buttons (no typing commands) that moves your files
  from your computer up to GitHub.
- **DNS** — the internet's address book. It's what tells sheastreeter.com to show *your*
  website. You'll edit it at Namecheap, where you bought the domain.

> **Where your project lives:** the folder
> `C:\Users\sashea\Projects\Website`. Every instruction below refers to this folder.
>
> **Note (moved out of Dropbox):** the project used to sit inside Dropbox, but Dropbox and
> the website-building tool (Quarto) kept fighting over the same files, causing "file in use"
> errors. The project now lives at the plain path above, outside Dropbox. Your old Dropbox
> copy (`...\Dropbox (Personal)\Academic\Projects\Website`) is kept as a frozen backup — do
> **not** work in it; once the site is on GitHub (Phase 2), GitHub becomes your backup and the
> Dropbox copy can be deleted.

---

## Phase 1 — Preview the website on your computer

### Step 1. Install Quarto

1. Go to **<https://quarto.org/docs/get-started/>** in your web browser.
2. Click the **Windows** download button. A file ending in `.msi` will download.
3. Double-click the downloaded file and click **Next / Install** until it finishes.

> **If the installer refuses to run** ("another installation is already in progress"):
> restart your computer and try again. Something else on your PC was mid-install when we
> tried earlier, and a restart clears it.

### Step 2. Open the project in a terminal

A "terminal" is just a window where you type a command. The easy way:

1. Open **File Explorer** and navigate to the project folder (path above).
2. Click once in the **address bar** at the top (where the folder path is shown), type
   `powershell`, and press **Enter**. A blue window opens, already pointing at the folder.

### Step 3. Start the preview

In that blue window, type this and press **Enter**:

```
quarto preview
```

After a few seconds, your web browser will open showing your website. **This is your site.**
Click around: Home, Research, Teaching, CV, and the Police Killings data page. On the data
page, confirm the **map appears** and the **charts and filters work** — this is the one part
we couldn't test automatically.

- To **stop** the preview, go back to the blue window and press **Ctrl + C**.
- **Nothing you do here is public yet** — this is only on your computer.

> **If you see an error mentioning a file "in use":** make sure you're running the command in
> the new folder (`C:\Users\sashea\Projects\Website`), **not** the old Dropbox copy. The move
> out of Dropbox is what fixes this error; running it inside Dropbox brings it back.

**✅ Checkpoint:** you can see the website in your browser and the data page's map + charts
work. If anything looks wrong, note it and we'll fix it next session — you can still continue.

---

## Phase 2 — Publish the files to GitHub

### Step 4. Make sure you have a GitHub account

Your username is **sheastreeter**. If you can log in at **<https://github.com/login>**,
you're set. If not, create a free account at **<https://github.com/signup>** (you choose the
username, email, and password — I can't do this for you).

### Step 5. Install GitHub Desktop

1. Go to **<https://desktop.github.com/>** and click **Download for Windows**.
2. Install and open it. When it asks, **Sign in** with your GitHub account from Step 4.

### Step 6. Publish the project

1. In GitHub Desktop's top menu: **File → Add local repository**.
2. Click **Choose…**, select the project folder (path at the top of this guide), and confirm.
   - If it says the folder "is not a Git repository," click the offered link to
     **create a repository here**, then click **Create repository**. (This just prepares the
     folder; it doesn't change your files.)
3. You'll see a list of the project's files on the left. In the bottom-left box, type a short
   message like `Initial website` and click **Commit to main**. (A "commit" is a saved
   snapshot.)
4. At the top, click **Publish repository**.
   - **Uncheck** "Keep this code private" if you're comfortable with the site's *source* being
     public (this is normal and expected for a personal website — visitors never see it, only
     the finished pages). Keeping it private also works but needs a paid setting for Pages, so
     **public is recommended.**
   - Leave the name as is and click **Publish repository**.

Your files are now on GitHub.

### Step 7. Turn on the publishing service (GitHub Pages)

1. In your web browser, go to your repository:
   **`https://github.com/sheastreeter/`** and click the repository you just published.
2. Publishing runs automatically on every upload. Click the **Actions** tab near the top and
   wait for the **"Deploy website"** job to finish with a green check (1–3 minutes). It's
   building your site and placing it on a special branch called `gh-pages`.
   - **If it shows a red X mentioning permissions:** go to **Settings → Actions → General**,
     scroll to **Workflow permissions**, choose **Read and write permissions**, click
     **Save**, then re-run the job (Actions tab → the failed run → **Re-run all jobs**).
3. Now click the **Settings** tab → **Pages** (left sidebar). Under **Build and deployment →
   Source**, choose **Deploy from a branch**. Set the branch to **`gh-pages`** and the folder
   to **`/ (root)`**, then click **Save**.
4. Wait ~1 minute, refresh, and GitHub will show a link like
   `https://sheastreeter.github.io/…`. Open it — **your site is now live on the internet.**

**✅ Checkpoint:** the site loads at the `github.io` link. The custom domain comes next.

---

## Phase 3 — Connect your domain (sheastreeter.com)

This has two halves: tell **GitHub** your domain, and tell **Namecheap** where to send it.

### Step 8. Tell GitHub your domain

1. In your repository: **Settings → Pages**.
2. Under **Custom domain**, type **`sheastreeter.com`** and click **Save**.
   (You may briefly see a "DNS check in progress" warning — that's expected until Step 9 is done.)

### Step 9. Point the domain at GitHub (at Namecheap)

1. Log in at **<https://www.namecheap.com/>**.
2. Click **Domain List** (left menu) → find **sheastreeter.com** → click **Manage**.
3. Click the **Advanced DNS** tab.
4. **Delete** any pre-existing records that Namecheap added by default (often a "CNAME
   Record" for `www` pointing to `parkingpage`, and a "URL Redirect" or "A Record" on `@`).
   Use the trash-can icon on each.
5. Click **Add New Record** and create these **five** records exactly:

   | Type | Host | Value | TTL |
   |------|------|-------|-----|
   | A Record | `@` | `185.199.108.153` | Automatic |
   | A Record | `@` | `185.199.109.153` | Automatic |
   | A Record | `@` | `185.199.110.153` | Automatic |
   | A Record | `@` | `185.199.111.153` | Automatic |
   | CNAME Record | `www` | `sheastreeter.github.io.` | Automatic |

   (The four A records are GitHub's official addresses. The CNAME sends `www.sheastreeter.com`
   to your GitHub site. The trailing dot after `.io` is fine if Namecheap keeps it.)
6. Click the green **checkmark / Save All Changes**.

### Step 10. Turn on the secure lock (HTTPS)

1. Wait a little (often 15–30 minutes; occasionally a few hours) for the address book to
   update.
2. Return to **GitHub → your repo → Settings → Pages**. When the DNS check passes, tick
   **Enforce HTTPS**. This gives visitors the padlock icon and an `https://` address.

### Step 11. Visit your website

Open **<https://sheastreeter.com>**. 🎉

- If it doesn't work immediately, wait longer — DNS changes can take up to 24 hours (usually
  much less). Try again later before worrying.

**✅ Checkpoint:** sheastreeter.com shows your website with a padlock in the address bar.

---

## After launch — updating the site

Whenever the website's files change (new publication, refreshed CV, new data), the update
flow is simple:

1. Open **GitHub Desktop**, type a short message (e.g. `Add 2024 paper`), click **Commit to
   main**, then **Push origin** at the top.
2. GitHub automatically rebuilds and republishes within a couple of minutes. That's it.

---

## What Claude can do for you next session (so you don't have to)

These are *not* on your to-do list — bring them to a future session and I'll handle them:

- **Connect more police-killings data** — send me the file with the **protest-outcome
  column** and any additional years; I'll wire it into the explorer and extend the filters.
- **Polish the writing** — review and revise the bio, research summaries, and teaching text.
- **Fix anything you noticed** in the preview (layout, wording, a chart, colors).
- **Set up the repository from the command line** if you'd prefer not to use GitHub Desktop.
- **Add features** — a news/blog section, publications sorted automatically, dark mode, etc.

## Your short checklist

- [ ] Step 1–3: Install Quarto and preview the site locally.
- [ ] Step 4–6: GitHub account + GitHub Desktop + publish the project.
- [ ] Step 7: Confirm the deploy ran and set Pages source to `gh-pages`.
- [ ] Step 8–9: Add the custom domain in GitHub and the 5 DNS records at Namecheap.
- [ ] Step 10–11: Enforce HTTPS and confirm sheastreeter.com loads.
- [ ] Send Claude the protest-coded / additional-year data when ready.
