# WebDAV Server
A simple WebDAV server in Go

## Usage
Run with argument `-h` or `--help`:
```
  -dir string
        Directory to serve from. Default: CWD
  -port int
        Port to serve on. Default: 80 (default 80)
  -prefix string
        URL to strip from resource paths. None by default
  -url string
        Root url to handle. Default: / (default "/")
```

## Optimization
If you are running `nginx` or any other reverse proxy in front, you may want to let it handle `GET` requests instead of this server to save resources.

### Example nginx configuration
```
# must be same as webdav server root
root /mnt;
# don't limit big uploads
client_max_body_size 0;

location / {
    if ($request_method != GET) {
        # pass webdav handling
        proxy_pass http://webdav:8080;
    }
    # handle GET requests directly
}
```