Every time you edit the config run: `rex config check` to check it's validity

Read `docs/rex-notes.md` before adding or changing actions: it has the file layout,
conventions, and the server-focus vs client-focus gotcha (use `rex do session.select`
to move the user's view, not `rex window focus`).
