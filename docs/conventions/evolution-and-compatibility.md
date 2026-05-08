# Evolution, replacement, and backward compatibility

This project is **pre-release** unless a release is explicitly tagged and deployed. Until then:

## Default: no parallel “legacy” support

- **Do not** maintain old and new **on-disk formats**, **request shapes**, or **public APIs** side by side unless the product owner **explicitly** asks for backward compatibility.
- **Full replacement** of a feature or format is acceptable: migrate the code and tests to the new implementation; you do **not** have to keep readers/writers for superseded behaviour “just in case.”
- When **compatibility becomes a requirement** (expected to be **rare**), treat it as a deliberate product decision: document it, add targeted tests, and implement only the overlap that is agreed.

## Testing

- **Additive behaviour** → **add** tests that match the real contract (files, DB, HTTP), as in [`testing.md`](testing.md).
- If you **replace** a contract, **update or replace** tests to assert the **new** contract.

## Related docs

- [`testing.md`](testing.md)
