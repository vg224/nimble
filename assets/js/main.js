// Mobile menu
const toggle = document.querySelector('.nav-toggle');
const nav = document.querySelector('.nav');
if (toggle && nav) {
  toggle.addEventListener('click', () => {
    const open = nav.classList.toggle('open');
    toggle.setAttribute('aria-expanded', open);
  });
}

// Footer year
document.querySelectorAll('[data-year]').forEach(el => { el.textContent = new Date().getFullYear(); });

// Contact form (Formspree) — submits without leaving the page
document.querySelectorAll('form.form').forEach(form => {
  form.addEventListener('submit', async (e) => {
    e.preventDefault();
    const status = form.querySelector('.form-status');
    const btn = form.querySelector('button[type=submit]');
    if (form.action.includes('YOUR_FORM_ID')) {
      status.textContent = 'Form not configured yet — please email vg@nimbleits.com.';
      return;
    }
    btn.disabled = true;
    status.textContent = 'Sending…';
    try {
      const res = await fetch(form.action, {
        method: 'POST',
        body: new FormData(form),
        headers: { Accept: 'application/json' }
      });
      if (res.ok) {
        form.reset();
        status.textContent = 'Thank you! We’ll be in touch shortly.';
      } else {
        status.textContent = 'Something went wrong. Please email vg@nimbleits.com.';
      }
    } catch {
      status.textContent = 'Network error. Please email vg@nimbleits.com.';
    }
    btn.disabled = false;
  });
});
