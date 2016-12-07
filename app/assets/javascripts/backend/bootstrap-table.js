window.bootstrapTableIcons = {
    "refresh":     "fa-refresh",
    "toggle":      "fa-toggle-on",
    "columns":     "fa-th-list",
    "detailOpen":  "fa-info-circle text-info",
    "detailClose": "fa-times-circle text-danger"
};

function detailFormatter(index, row, element) {
  var raw_response = Prism.highlight(row[8], Prism.languages.json);
  return "<pre class='language-json'><code>" + raw_response + "</code></pre>";
}

function attachmentDetailFormatter(index, row, element) {
  var raw_response = Prism.highlight(row[6], Prism.languages.json);
  return "<pre class='language-json'><code>" + raw_response + "</code></pre>";
}
