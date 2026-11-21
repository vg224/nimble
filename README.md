# Nimble IT Solutions — website (GitHub Pages)

Static site for www.nimbleits.com, repositioned (Nov 2026) around healthcare IT and
Nimble Health Intelligence. Plain HTML/CSS/JS, no build step.

```
index.html              Home
platform/               Nimble Health Intelligence modules
solutions/              MSOs (#msos), practices (#practices), PT IT (#pt)
security/               Security & HIPAA, FAQ
about/  contact/        About, Contact
digital-services/       Original coach/online-business offers (linked from footer)
404.html                Not-found page
store/, the-launch-kit/, store/p/…, cart/   Redirects from old URLs
assets/css/style.css    All styles (colors/fonts at the top)
assets/js/main.js       Mobile menu + contact form
images/                 Created by setup.sh
CNAME                   Custom domain (www.nimbleits.com)
```

## 1. One-time setup (on your Mac, before cancelling Squarespace)

```bash
cd ~/Projects/nimble
bash setup.sh          # downloads images, asks for the contact email to show
python3 -m http.server 8000   # preview at http://localhost:8000
```

## 2. Contact form (Formspree, free)

1. Sign up at https://formspree.io → **New form** → copy the form ID (e.g. `xyzabcd`).
2. Replace `YOUR_FORM_ID` everywhere:
   ```bash
   grep -rl YOUR_FORM_ID --include=*.html . | xargs sed -i '' 's/YOUR_FORM_ID/xyzabcd/g'
   ```

## 3. "Book a demo" buttons

All demo / schedule buttons go to your Calendly link. To change it, search and replace
`calendly.com/vg-nimbleits` across the HTML files.

## 4. Publish to GitHub Pages

```bash
cd ~/Projects/nimble
git init -b main
git add .
git commit -m "Initial site"
# create an empty repo on github.com (e.g. nimble-website), then:
git remote add origin https://github.com/<your-username>/nimble-website.git
git push -u origin main
```

On GitHub: **Settings → Pages → Build and deployment → Source: Deploy from a branch → `main` / `(root)`**.
Under **Custom domain** it should already show `www.nimbleits.com` (from CNAME).

## 5. Point the domain (DNS)

Where your DNS is managed (Squarespace Domains, unless you've moved it):

| Type  | Host | Value |
|-------|------|-------|
| CNAME | www  | `<your-username>.github.io` |
| A     | @    | 185.199.108.153 |
| A     | @    | 185.199.109.153 |
| A     | @    | 185.199.110.153 |
| A     | @    | 185.199.111.153 |

Remove the existing Squarespace `www` CNAME and `@` A records first.
**Don't touch MX / TXT (SPF, DKIM) records** — those run your email.

After DNS propagates (minutes to a few hours), tick **Enforce HTTPS** in Settings → Pages.
Optional: verify the domain under your GitHub account settings → Pages to prevent takeover.

## 6. Cancel Squarespace — last

Only after the new site is live over HTTPS. If your domain is *registered* with
Squarespace, keep the domain (or transfer it) — cancel only the website plan.

## Editing later

Edit the HTML directly, commit, push — GitHub redeploys in about a minute.
