# Form Validation UI Pattern (Bootstrap + Grails)

This project standardizes form validation behavior using the same pattern as `systemAdmin/createUser`.

## Goal

Show validation failures clearly at two levels:

- A top summary alert for global/domain/service errors.
- Field-level inline errors under each input.

Preserve submitted values by re-rendering the form with the original command object.

## Controller Pattern

1. Bind request to a command object with `constraints`.
2. If `cmd.hasErrors()`, render the form view/partial with `cmd`.
3. Perform service/domain work.
4. If service result has errors/failures, render the form with `cmd` and `result`.
5. On success, set flash success and redirect.

Example shape:

```groovy
def saveThing(CreateThingCommand cmd) {
    if (cmd.hasErrors()) {
        render view: 'createThing', model: [cmd: cmd]
        return
    }

    CreateThingResult result = thingService.create(cmd)
    if (result.hasErrors()) {
        render view: 'createThing', model: [cmd: cmd, result: result]
        return
    }

    flash.message = 'Thing created.'
    redirect action: 'index'
}
```

## GSP Pattern

### 1) Summary alert (global errors)

- Use `alert alert-danger`.
- Render non-field command errors.
- Render domain errors from `result` if present.
- Render service failure enum/messages if present.

### 2) Field-level errors

- Keep Bootstrap `form-control` inputs.
- Use `g:hasErrors bean="${cmd}" field="fieldName"` and `g:eachError`.
- Render messages inside `invalid-feedback d-block`.

Example shape:

```gsp
<g:hasErrors bean="${cmd}" field="email">
    <div class="invalid-feedback d-block">
        <g:eachError bean="${cmd}" field="email" var="err">
            <div><g:message error="${err}"/></div>
        </g:eachError>
    </div>
</g:hasErrors>
```

## HTMX Adaptation

For HTMX forms, keep the same validation rules and rendering pattern, but return fragments:

- Initial page returns a container + trigger.
- `GET` form endpoint returns only the form fragment.
- `POST` save endpoint:
  - on validation failure: re-render the same form fragment with `cmd`/`result` (HTTP 200 is fine for swap).
  - on success: return success fragment (or updated list fragment) to swap target.

Use the same Bootstrap classes in fragments so validation visuals are consistent with full-page forms.

## HTMX endpoint naming

Use action names that make the response shape obvious for fragment-only endpoints:

- Fragment-only `GET` actions should use the `Partial` suffix (for example `formPartial`, `listPartial`).
- Keep full-page actions unsuffixed (for example `index`, `show`).
- If an endpoint is intended to support both full-page and fragment responses, use a neutral unsuffixed action name and branch on request context rather than forcing a `Partial` name.

## Why this pattern

- Users see both broad and specific errors.
- No lost input after validation errors.
- Works for full-page forms and HTMX componentized forms with minimal divergence.
