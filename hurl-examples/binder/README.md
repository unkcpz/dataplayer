# binder/ — no outbound HTTP calls

## Source: app/vres/binder.py  VREBinder.post()

VREBinder makes **no outbound HTTP requests** at all.

Its entire `post()` flow is local filesystem + git operations:

1. `_create(repo)`                   → `os.mkdir(repo)`
2. `_write_source_files(repo)`       → unzips the RO-Crate body into `repo/`
3. `_initialize_temporary_git_repo(repo)` → `git.Repo.init()`, adds files, commits
4. `_write_example_file(repo)`       → writes `.git/git-daemon-export-ok`
5. `_get_binder_url(request_id)`     → constructs and returns the redirect URL

The **redirect URL** returned to the caller (no HTTP call made here either):

```
{svc_url}/git/{urllib.parse.quote_plus("https://{settings.host}/git/{request_id}")}/HEAD
```

For example, if:
- `svc_url`       = `https://replay.notebooks.egi.eu`
- `settings.host` = `dispatcher.example.org`
- `request_id`    = `abc-123`

Then the URL is:
```
https://replay.notebooks.egi.eu/git/https%3A%2F%2Fdispatcher.example.org%2Fgit%2Fabc-123/HEAD
```

The Binder/EGI-Notebooks service then GETs that URL from the Dispatcher's
own `/git/<request_id>` endpoint (served by git-daemon / nginx), which is
an internal Dispatcher concern — not an outbound call from the VRE plugin.

**There is nothing to express as a hurl file for this target.**
