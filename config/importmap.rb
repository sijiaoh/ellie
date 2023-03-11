# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"

pin_all_from "app/javascript/utils", under: "utils"
pin_all_from "vendor/javascript/tinymce_languages", under: "tinymce_languages"

pin "google_analytics", to: "google_analytics.js"

# CodeMirror
pin "@codemirror/state", to: "https://ga.jspm.io/npm:@codemirror/state@6.2.0/dist/index.js"
pin "@codemirror/view", to: "https://ga.jspm.io/npm:@codemirror/view@6.9.2/dist/index.js"
pin "style-mod", to: "https://ga.jspm.io/npm:style-mod@4.0.0/src/style-mod.js"
pin "w3c-keyname", to: "https://ga.jspm.io/npm:w3c-keyname@2.2.6/index.es.js"
# CodeMirror lang markdown
pin "@codemirror/lang-markdown", to: "https://ga.jspm.io/npm:@codemirror/lang-markdown@6.1.0/dist/index.js"
pin "@codemirror/autocomplete", to: "https://ga.jspm.io/npm:@codemirror/autocomplete@6.4.2/dist/index.js"
pin "@codemirror/lang-css", to: "https://ga.jspm.io/npm:@codemirror/lang-css@6.1.1/dist/index.js"
pin "@codemirror/lang-html", to: "https://ga.jspm.io/npm:@codemirror/lang-html@6.4.2/dist/index.js"
pin "@codemirror/lang-javascript", to: "https://ga.jspm.io/npm:@codemirror/lang-javascript@6.1.4/dist/index.js"
pin "@codemirror/language", to: "https://ga.jspm.io/npm:@codemirror/language@6.6.0/dist/index.js"
pin "@lezer/common", to: "https://ga.jspm.io/npm:@lezer/common@1.0.2/dist/index.js"
pin "@lezer/css", to: "https://ga.jspm.io/npm:@lezer/css@1.1.1/dist/index.es.js"
pin "@lezer/highlight", to: "https://ga.jspm.io/npm:@lezer/highlight@1.1.3/dist/index.js"
pin "@lezer/html", to: "https://ga.jspm.io/npm:@lezer/html@1.3.2/dist/index.es.js"
pin "@lezer/javascript", to: "https://ga.jspm.io/npm:@lezer/javascript@1.4.1/dist/index.es.js"
pin "@lezer/lr", to: "https://ga.jspm.io/npm:@lezer/lr@1.3.3/dist/index.js"
pin "@lezer/markdown", to: "https://ga.jspm.io/npm:@lezer/markdown@1.0.2/dist/index.js"

pin "marked", to: "https://ga.jspm.io/npm:marked@4.2.12/lib/marked.esm.js"
pin "dompurify", to: "https://ga.jspm.io/npm:dompurify@3.0.1/dist/purify.js"
