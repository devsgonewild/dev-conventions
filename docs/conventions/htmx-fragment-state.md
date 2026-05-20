# HTMX fragment state (hx-include)

For server-rendered fragments where (page) state needs to be maintained whilst controls in the fragment change it, keep stable identity in a hidden form and put per-action overrides in `data-role` wrappers with hidden inputs, then wire links and forms with `hx-include` instead of building query strings in the GSP.

**Example:** `nbn-components-plugin/grails-app/views/components/_simpleDataTable.gsp` — read that template for the full pattern (`#<id>-state`, `#<id>-pagination-state`, `data-role`, `hx-get` on the partial URL only).
