#!/bin/bash
# Lala TV - Server Setup Script
# Run on GPU server (gpu-server)

set -e

echo "=== Lala TV - Server Setup ==="
echo ""

# Create data directories
echo "[1/4] Creating data directories..."
sudo mkdir -p /data/{torrents,media/{movies,tv}}
sudo mkdir -p /opt/lala-tv/{sonarr,radarr,prowlarr,rdt-client,bazarr,seerr}
sudo chown -R 1000:1000 /data /opt/lala-tv

# Set permissions for GPU access
echo "[2/4] Setting GPU permissions..."
sudo usermod -aG render,video $(whoami) 2>/dev/null || true

# Copy branding assets
echo "[3/4] Copying branding assets..."
sudo mkdir -p /opt/jellyfin/config/branding
sudo cp -r jellyfin/branding/* /opt/jellyfin/config/branding/ 2>/dev/null || true

# Deploy stack
echo "[4/4] Deploying Docker Compose stack..."
docker compose up -d

echo ""
echo "=== Lala TV Deployed ==="
echo ""
echo "Services:"
echo "  Jellyfin:      http://localhost:8096"
echo "  Sonarr:        http://localhost:8989"
echo "  Radarr:        http://localhost:7878"
echo "  Prowlarr:      http://localhost:9696"
echo "  rdt-client:    http://localhost:6500"
echo "  Bazarr:        http://localhost:6767"
echo "  FlareSolverr:  http://localhost:8191"
echo "  Seerr:         http://localhost:5055"
echo ""
echo "Next steps:"
echo "  1. Configure Jellyfin branding (Dashboard > Branding > Server Name: 'Lala TV')"
echo "  2. Set up Real-Debrid API key in rdt-client"
echo "  3. Configure Prowlarr indexers"
echo "  4. Connect Sonarr/Radarr to Prowlarr and rdt-client"
echo "  5. Add Jellyfin connection in Sonarr/Radarr (Settings > Connect)"
echo "  6. Set up Seerr with Jellyfin + Sonarr + Radarr"
