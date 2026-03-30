# Lala TV

Self-hosted Netflix. Fully automated media streaming platform.

![Lala TV](branding/logos/Lala%20TV%20-%20Dark%20Mode.png)

## Architecture

```
Users (Lala TV App/Web) → Jellyfin (streaming)
                              ↑
              Sonarr (TV) + Radarr (Movies)
                              ↑
                     Prowlarr (indexers) → FlareSolverr
                              ↑
                   rdt-client (Real-Debrid proxy)
                              ↑
                   Real-Debrid (cached CDN downloads)
```

## Stack

| Service | Purpose | Port |
|---------|---------|------|
| **Jellyfin** | Media streaming server (branded as Lala TV) | 8096 |
| **Sonarr** | TV show automation - auto-grab new episodes | 8989 |
| **Radarr** | Movie automation - auto-grab new movies | 7878 |
| **Prowlarr** | Centralized indexer management | 9696 |
| **rdt-client** | Real-Debrid proxy (qBittorrent API compatible) | 6500 |
| **Bazarr** | Automated subtitle downloads | 6767 |
| **FlareSolverr** | Cloudflare bypass for indexers | 8191 |
| **Seerr** | Media request management UI | 5055 |

## How It Works

1. **Add a show or movie** via Seerr (request UI) or directly in Sonarr/Radarr
2. **Prowlarr** searches configured indexers for the best release
3. **rdt-client** sends the torrent to Real-Debrid (instant if cached)
4. **Real-Debrid** resolves and serves the file via CDN
5. **Sonarr/Radarr** imports, renames, and organizes the file
6. **Jellyfin** detects the new media and makes it available for streaming
7. **Bazarr** auto-downloads matching subtitles

No actual torrenting. No seeding. No copyright notices. Just instant, cached HTTPS downloads.

## Apps

Custom branded "Lala TV" mobile apps:

- **Android** - Based on Streamyfin (React Native/Expo)
- **iOS** - Based on Streamyfin (React Native/Expo)

## Deployment

Server: GPU Server (4x AMD RX 570, VA-API hardware transcoding)

```bash
cd server
chmod +x setup.sh
./setup.sh
```

## Branding

- Server name: "Lala TV"
- Custom CSS theme with golden accent color
- Custom logos for dark/light modes
- Pre-configured server URL in mobile apps

## License

Private project.
